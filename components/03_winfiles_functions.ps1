<#
.SYNOPSIS
    winfiles utility functions
#>

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
    Update-Help -Force
    choco upgrade all
}

function Run-Script($folder, $script) {
    $profileDir = Split-Path -parent $profile
    $scriptsDir = Join-Path $profileDir $folder
    Push-Location $profileDir
    iex ". ./$script.ps1"
    Pop-Location
}

function Winfiles-CLI($action, $option) {
    Switch ($action) {
        'update'    { System-Update }
        'config'    {
            if (!$option) { Write-Error "Missing 'option' parameter for config tool to run" }
            else { Run-Script('config', $option) }
        }
    }
}
Set-Alias winfiles Winfiles-CLI
