<#
.SYNOPSIS
    Run all windows install scripts

.DESCRIPTION
    Ensures to be run as Administrator

.NOTES
    Adapted form https://github.com/jayharris/dotfiles-windows
#>


Assert-PowershellAdmin

Push-Location (Get-ProfilePath "config/windows")
Get-ChildItem | foreach {
    Invoke-Expression (Get-Content $_.FullName -Raw)
}
Pop-Location
