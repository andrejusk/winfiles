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

$profileDir = Split-Path -parent $profile
$windowsDir = Join-Path $profileDir "config/windows"
Push-Location $windowsDir
Get-ChildItem | foreach { Invoke-Expression (Get-Content $_.FullName -Raw) }
Pop-Location
