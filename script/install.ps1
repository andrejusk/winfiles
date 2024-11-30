<#
.SYNOPSIS
    Run all install.d scripts
#>

Push-Location "$PSScriptRoot\install.d"
try {
    Get-ChildItem | ForEach-Object { . $_.FullName }
} finally {
    Pop-Location
}
