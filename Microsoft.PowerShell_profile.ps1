<#
.SYNOPSIS
    Microsoft.PowerShell_profile

.DESCRIPTION
    Assert PS version 5 or greater

    Run all scripts in components directory

    Execute extra.ps1 if exists

.NOTES
    Adapted from https://github.com/jayharris/dotfiles-windows
#>


$version = $PSVersionTable.PSVersion.Major
if ($version -lt 5) { Write-Error "Unsupported PowerShell version $version" } 

else {

    # profileDir/components/**
    $profileDir = Split-Path -parent $profile
    $componentsPath = Join-Path $profileDir "components"
    Push-Location $componentsPath
    Get-ChildItem | foreach { 
        Invoke-Expression (Get-Content $_.FullName -Raw) 
    }
    Pop-Location

}
