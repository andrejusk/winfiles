<#
.SYNOPSIS
  Sets up Hyper-V
#>

Write-Host "Configuring Hyper-V..." -ForegroundColor "Yellow"
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V -All -LogLevel 1
