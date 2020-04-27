<#
.SYNOPSIS
    Install folder contents to PowerShell Profile folder
    as configured in bootstrap.json next to the script

.DESCRIPTION
    Can be run as user.

    Steps:
        1. Load in configuration file
        2. Create necessary dirs if don't exist
        3. Wipe dirs to ensure fresh setup
        4. Copy all necessary files

.EXAMPLE
    $ . .\bootstrap.ps1

.NOTES
    Adapted from https://github.com/jayharris/dotfiles-windows
#>


$sourceDir      = $PSScriptRoot
$profileDir     = Split-Path -parent $profile

$bootstrapJson      = Join-Path $sourceDir "bootstrap.json"
$bootstrapConfig    = Get-Content -Path $bootstrapJson | ConvertFrom-Json


New-Item $profileDir -ItemType Directory -Force -ErrorAction SilentlyContinue | Out-Null
foreach ($target in $bootstrapConfig.targets) {

    # Verify 'src' and 'dst' are given
    if (!$target.src) { Write-Error "Missing 'src' argument for $target"; exit }
    if (!$target.dst) { Write-Error "Missing 'dst' argument for $target"; exit }

    # Supported destination paths
    $dir = Switch ($target.base) {
        'appdata'   { $env:APPDATA }
        'home'      { $home }
        default     { $profileDir }
    }
    $dst = Join-Path $dir $target.dst

    # Ensure dst exists
    New-Item $dst -ItemType Directory -Force -ErrorAction SilentlyContinue | Out-Null

    # Wipe dst if required
    if ($target.wipe) { Get-ChildItem $dst -Include ** | Remove-Item }

    # Copy contents
    Copy-Item -Path $target.src -Destination $dst -Include ** -Exclude $target.exclude

}


Remove-Variable sourceDir
Remove-Variable profileDir
Remove-Variable bootstrapJson
Remove-Variable bootstrapConfig
