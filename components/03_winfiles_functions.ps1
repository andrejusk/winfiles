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
