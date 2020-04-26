<#
.SYNOPSIS
    Entrypoint script to perform git-less setup of the repo

.DESCRIPTION
    * download repository zip and extract to temp dir
    * run bootstrap script
    * spawn new powershell

.EXAMPLE
    . { iwr -useb https://<host>/install.ps1 } | iex; install

.NOTES
    Adapted from https://github.com/jayharris/dotfiles-windows
#>


$account        = "andrejusk"
$repo           = "winfiles"
$branch         = "master"

$guid           = [guid]::NewGuid()
$repositoryUrl  = "https://github.com/$account/$repo/archive/$branch.zip"

$tempDir        = Join-Path $env:TEMP $repo
if (![System.IO.Directory]::Exists($tempDir)) {[System.IO.Directory]::CreateDirectory($tempDir)}

$winfilesZip    = Join-Path $tempDir "$branch-$guid.zip"
$winfilesDir    = Join-Path $tempDir "$guid"


function Download-File {
    param (
        [string]$url,
        [string]$file
    )
    Write-Host "Downloading $url to $file"
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls13
    Invoke-WebRequest -Uri $url -OutFile $file
}

function Unzip-File {
    param (
        [string]$file,
        [string]$destination = (Get-Location).Path
    )
    $filePath = Resolve-Path $file
    $destinationPath = $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath($destination)
    Write-Host "Extracting $filePath to $destinationPath"
    If (($PSVersionTable.PSVersion.Major -ge 3) -and
        (
            [version](Get-ItemProperty -Path "HKLM:\Software\Microsoft\NET Framework Setup\NDP\v4\Full" -ErrorAction SilentlyContinue).Version -ge [version]"4.5" -or
            [version](Get-ItemProperty -Path "HKLM:\Software\Microsoft\NET Framework Setup\NDP\v4\Client" -ErrorAction SilentlyContinue).Version -ge [version]"4.5"
        )) {
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

Download-File $repositoryUrl $winfilesZip
Unzip-File $winfilesZip $winfilesDir

Push-Location $winfilesDir
& .\bootstrap.ps1
Pop-Location

$newProcess = new-object System.Diagnostics.ProcessStartInfo "PowerShell";
$newProcess.Arguments = "-nologo";
[System.Diagnostics.Process]::Start($newProcess);
exit
