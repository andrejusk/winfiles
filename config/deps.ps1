<#
.SYNOPSIS
  Install dependencies and packages
#>


Assert-PowershellAdmin

if ((which choco) -eq $null) {
    Write-Host "Installing Chocolatey..." -ForegroundColor "Yellow"
    iex (new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1')
    Refresh-Environment
    choco feature enable -n=allowGlobalConfirmation
}

Write-Host "Installing deps.config..." -ForegroundColor "Yellow"
choco -v
choco install --confirm (Get-ProfilePath "config/deps.config")
choco install --confirm firefox-dev --prerelease
choco upgrade --confirm all
Refresh-Environment
