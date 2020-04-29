<#
.SYNOPSIS
  Install dependencies and packages

.DESCRIPTION
  Elevates self if not admin

.NOTES
  Original author: https://github.com/jayharris/dotfiles-windows
#>

Assert-PowershellAdmin

# Write-Host "Updating Help..." -ForegroundColor "Yellow"
# Update-Help -Force

Write-Host "Installing Package Providers..." -ForegroundColor "Yellow"
Get-PackageProvider NuGet -Force | Out-Null

Write-Host "Installing PowerShell Modules..." -ForegroundColor "Yellow"
Install-Module Posh-Git -Scope CurrentUser -Force
Install-Module PSWindowsUpdate -Scope CurrentUser -Force

Write-Host "Installing Desktop Utilities..." -ForegroundColor "Yellow"
if ((which cinst) -eq $null) {
    iex (new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1')
    Refresh-Environment
    choco feature enable -n=allowGlobalConfirmation
}
choco -v
choco install (Get-ProfilePath "config/deps.config")
choco install firefox-dev --prerelease
Refresh-Environment
