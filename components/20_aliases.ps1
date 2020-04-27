<#
.SYNOPSIS
    PowerShell aliases

.DESCRIPTION
    * Easier navigation and shortcuts
    * Fix bash and posh aliases
    * Alias to functions

.NOTES
    Adapted from https://github.com/jayharris/dotfiles-windows
#>

${function:~} = { Set-Location ~ }
${function:Set-ParentLocation} = { Set-Location .. }; Set-Alias ".." Set-ParentLocation
${function:...} = { Set-Location ..\.. }
${function:....} = { Set-Location ..\..\.. }
${function:.....} = { Set-Location ..\..\..\.. }
${function:......} = { Set-Location ..\..\..\..\.. }
${function:profile} = { Set-Location (Split-Path -parent $profile) }
${function:workspace} = { Set-Location $env:WORKSPACE }
${function:dt} = { Set-Location ~\Desktop }
${function:docs} = { Set-Location ~\Documents }
${function:dl} = { Set-Location ~\Downloads }

Set-Alias time Measure-Command
if (Get-Command wget.exe -ErrorAction SilentlyContinue | Test-Path) {
  rm alias:wget -ErrorAction SilentlyContinue
}
if (Get-Command ls.exe -ErrorAction SilentlyContinue | Test-Path) {
    rm alias:ls -ErrorAction SilentlyContinue
    # Set `ls` to call `ls.exe` and always use --color
    ${function:ls} = { ls.exe --color @args }
    # List all files in long format
    ${function:l} = { ls -lF @args }
    # List all files in long format, including hidden files
    ${function:la} = { ls -laF @args }
    # List only directories
    ${function:lsd} = { Get-ChildItem -Directory -Force @args }
} else {
    # List all files, including hidden files
    ${function:la} = { ls -Force @args }
    # List only directories
    ${function:lsd} = { Get-ChildItem -Directory -Force @args }
}
if (Get-Command curl.exe -ErrorAction SilentlyContinue | Test-Path) {
    rm alias:curl -ErrorAction SilentlyContinue
    # Set `ls` to call `ls.exe` and always use --color
    ${function:curl} = { curl.exe @args }
    # Gzip-enabled `curl`
    ${function:gurl} = { curl --compressed @args }
} else {
    # Gzip-enabled `curl`
    ${function:gurl} = { curl -TransferEncoding GZip }
}

Set-Alias mkd CreateAndSet-Directory
Set-Alias fs Get-DiskUsage
Set-Alias emptytrash Empty-RecycleBin
Set-Alias cleandisks Clean-Disks
Set-Alias reload Reload-Powershell
