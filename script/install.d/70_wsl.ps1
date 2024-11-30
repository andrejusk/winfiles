<#
.SYNOPSIS
  Sets up Hyper-V/WSL
#>


Write-Host "Configuring Hyper-V..." -ForegroundColor "Yellow"
Enable-WindowsOptionalFeature -Online -All -FeatureName "Microsoft-Hyper-V" -NoRestart -WarningAction SilentlyContinue | Out-Null

Write-Host "Configuring WSL..." -ForegroundColor "Yellow"
Enable-WindowsOptionalFeature -Online -All -FeatureName "Microsoft-Windows-Subsystem-Linux" -NoRestart -WarningAction SilentlyContinue | Out-Null
wsl --set-default-version 2
wsl --install --distribution Ubuntu-24.04
