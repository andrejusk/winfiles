<#
.SYNOPSIS
    Microsoft.PowerShell_profile

.DESCRIPTION
    Runs all scripts in components directory

.NOTES
    Adapted from https://github.com/jayharris/dotfiles-windows
#>


Push-Location (Join-Path (Split-Path -parent $profile) "components")
Get-ChildItem | foreach { Invoke-Expression (Get-Content $_.FullName -Raw) }
Pop-Location
