<#
.SYNOPSIS
    Profile for the Microsoft.Powershell Shell

.NOTES
    Original author: https://github.com/jayharris/dotfiles-windows
#>

$profileDir = Split-Path -parent $profile
$componentDir = Join-Path $profileDir "components"

Push-Location $componentDir
Get-ChildItem . | Where-Object {Test-Path "$_.ps1"} | ForEach-Object -process {
  Invoke-Expression ". .\$_.FullName"
}
Pop-Location

Write-Host "hello world!"
