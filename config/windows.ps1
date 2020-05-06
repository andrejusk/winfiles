<#
.SYNOPSIS
    Run all windows install script
#>


Assert-PowershellAdmin

Push-Location (Get-ProfilePath "config/windows")
Get-ChildItem | foreach {
    Invoke-Expression (Get-Content $_.FullName -Raw)
}
Pop-Location
