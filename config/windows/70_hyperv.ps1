<#
.SYNOPSIS
  Sets up Hyper-V
#>


Write-Host "Configuring Hyper-V..." -ForegroundColor "Yellow"

# Enable Hyper-V feature, surpress output
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V -All -LogLevel 1 -NoRestart
