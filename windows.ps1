<#
.SYNOPSIS
    Run all windows install scripts

.DESCRIPTION
    Ensures to be run as Administrator

.NOTES
    Adapted form https://github.com/jayharris/dotfiles-windows
#>


if (!(Verify-Elevated)) {
   $newProcess = new-object System.Diagnostics.ProcessStartInfo "PowerShell";
   $newProcess.Arguments = $myInvocation.MyCommand.Definition;
   $newProcess.Verb = "runas";
   [System.Diagnostics.Process]::Start($newProcess);
   exit
}

Push-Location "windows"
Get-ChildItem | foreach { Invoke-Expression (Get-Content $_.FullName -Raw) }
Pop-Location
