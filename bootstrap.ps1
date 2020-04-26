<#
.SYNOPSIS
    Copy folder contents to PowerShell Profile folder

.EXAMPLE
    . .\bootstrap.ps1

.NOTES
    Adapted from https://github.com/jayharris/dotfiles-windows
#>

$profileDir     = Split-Path -parent $profile
$componentDir   = Join-Path $profileDir "components"

New-Item $profileDir    -ItemType Directory -Force -ErrorAction SilentlyContinue | Out-Null
New-Item $componentDir  -ItemType Directory -Force -ErrorAction SilentlyContinue | Out-Null

Get-ChildItem $componentDir -Include ** | Remove-Item

Copy-Item -Path ./*.ps1         -Destination $profileDir    -Exclude "bootstrap.ps1"
Copy-Item -Path ./components/** -Destination $componentDir  -Include **
Copy-Item -Path ./home/**       -Destination $home          -Include **

Remove-Variable componentDir
Remove-Variable profileDir
