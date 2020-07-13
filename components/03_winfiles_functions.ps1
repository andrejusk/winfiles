<#
.SYNOPSIS
    winfiles utility functions
#>

function Get-RelativePath($path) {
    <# Return path relative to currently executed script #>
    return Join-Path $PSScriptRoot $path
}

function Get-ProfilePath($path) {
    <# Return path relative to profile folder #>
    return Join-Path (Split-Path -parent $profile) $path
}

function Create-Shortcut($source, $args, $destination) {
    echo $source
    echo $destination
    $WshShell = New-Object -comObject WScript.Shell
    $Shortcut = $WshShell.CreateShortcut($destination)
    $Shortcut.TargetPath = $source
    $Shortcut.Arguments = [string]$args
    $Shortcut.Save()
}

function Restart-Gpg {
    gpg-connect-agent killagent /bye
    gpg-connect-agent /bye
}

function Get-GpgKeyId($email) {
    return gpg --with-colons --keyid-format LONG --list-keys $email `
        | grep '^pub:-:4096:1:' | cut -d: -f5
}

function Get-GpgFingerprint($keyId) {
    return gpg --with-colons --fingerprint $keyId `
        | grep -m1 fpr | cut -d ':' -f 10
}

function Remove-FromPath($pathToRemove) {
    <# https://stackoverflow.com/a/39012021 #>
    # Get it
    $path = [System.Environment]::GetEnvironmentVariable(
        'PATH',
        'Machine'
    )
    # Remove unwanted elements
    $path = ($path.Split(';') | Where-Object { $_ -ne $pathToRemove }) -join ';'
    # Set it
    [System.Environment]::SetEnvironmentVariable(
        'PATH',
        $path,
        'Machine'
    )
}

function System-Update() {
    if (!(Verify-Elevated)) {
        $newProcess = new-object System.Diagnostics.ProcessStartInfo "PowerShell";
        $newProcess.Arguments = $myInvocation.MyCommand.Definition;
        $newProcess.Verb = "runas";
        [System.Diagnostics.Process]::Start($newProcess);

        exit
    }
    Install-WindowsUpdate -IgnoreUserInput -IgnoreReboot -AcceptAll
    Update-Module
    choco upgrade all
}

function Run-Script($folder, $script) {
    $script = Join-Path (Split-Path -parent $profile) "$folder/$script.ps1"
    iex $script
}

function Winfiles-CLI($action, $option) {
    Switch ($action) {
        "update"    { System-Update }
        "config"    {
            if (!$option) { Write-Error "Missing 'option' parameter for config tool to run, see README.md" }
            else { Run-Script "config" $option }
        }
        default { Write-Error "Missing 'action' parameter for tool to run, see README.md" }
    }
}
Set-Alias winfiles Winfiles-CLI
