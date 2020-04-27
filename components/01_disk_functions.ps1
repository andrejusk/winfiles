<#
.SYNOPSIS
    Disk utility functions

.NOTES
    Adapted from https://github.com/jayharris/dotfiles-windows
#>


function Get-DiskUsage([string] $path=(Get-Location).Path) {
    # Determine size of a file or total size of a directory
    Convert-ToDiskSize `
        ( `
            Get-ChildItem .\ -recurse -ErrorAction SilentlyContinue `
            | Measure-Object -property length -sum -ErrorAction SilentlyContinue
        ).Sum `
        1
}

function Clean-Disks {
    # Cleanup all disks (Based on Registry Settings in `windows/90_cleanup.ps1`)
    Start-Process "$(Join-Path $env:WinDir 'system32\cleanmgr.exe')" -ArgumentList "/sagerun:6174" -Verb "runAs"
}

function Convert-ToDiskSize {
    param ( $bytes, $precision='0' )
    foreach ($size in ("B","K","M","G","T")) {
        if (($bytes -lt 1000) -or ($size -eq "T")){
            $bytes = ($bytes).tostring("F0" + "$precision")
            return "${bytes}${size}"
        }
        else { $bytes /= 1KB }
    }
}

function Unzip-File {
    <#
    .SYNOPSIS
       Extracts the contents of a zip file.
    .DESCRIPTION
       Extracts the contents of a zip file specified via the -File parameter to the
    location specified via the -Destination parameter.
    .PARAMETER File
        The zip file to extract. This can be an absolute or relative path.
    .PARAMETER Destination
        The destination folder to extract the contents of the zip file to.
    .PARAMETER ForceCOM
        Switch parameter to force the use of COM for the extraction even if the .NET Framework 4.5 is present.
    .EXAMPLE
       Unzip-File -File archive.zip -Destination .\d
    .EXAMPLE
       'archive.zip' | Unzip-File
    .EXAMPLE
        Get-ChildItem -Path C:\zipfiles | ForEach-Object {$_.fullname | Unzip-File -Destination C:\databases}
    .INPUTS
       String
    .OUTPUTS
       None
    .NOTES
       Inspired by:  Mike F Robbins, @mikefrobbins
       This function first checks to see if the .NET Framework 4.5 is installed and uses it for the unzipping process, otherwise COM is used.
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true, ValueFromPipeline=$true)]
        [string]$File,

        [ValidateNotNullOrEmpty()]
        [string]$Destination = (Get-Location).Path
    )

    $filePath = Resolve-Path $File
    $destinationPath = $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath($Destination)

    if (($PSVersionTable.PSVersion.Major -ge 3) -and
       ((Get-ItemProperty -Path "HKLM:\Software\Microsoft\NET Framework Setup\NDP\v4\Full" -ErrorAction SilentlyContinue).Version -like "4.5*" -or
       (Get-ItemProperty -Path "HKLM:\Software\Microsoft\NET Framework Setup\NDP\v4\Client" -ErrorAction SilentlyContinue).Version -like "4.5*")) {

        try {
            [System.Reflection.Assembly]::LoadWithPartialName("System.IO.Compression.FileSystem") | Out-Null
            [System.IO.Compression.ZipFile]::ExtractToDirectory("$filePath", "$destinationPath")
        } catch {
            Write-Warning -Message "Unexpected Error. Error details: $_.Exception.Message"
        }
    } else {
        try {
            $shell = New-Object -ComObject Shell.Application
            $shell.Namespace($destinationPath).copyhere(($shell.NameSpace($filePath)).items())
        } catch {
            Write-Warning -Message "Unexpected Error. Error details: $_.Exception.Message"
        }
    }
}
