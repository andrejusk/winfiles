# winfiles

PowerShell profile, installation and dev tools for Windows

# Installation

If required, run as admin

```powershell
Set-ExecutionPolicy Unrestricted
```

To run without repository

```powershell
$source = "https://raw.github.com/andrejusk/winfiles/master/setup/install.ps1"
iex ((new-object net.webclient).DownloadString($source))
```

To run within repository

```powershell
. .\bootstrap.ps1
```

# Configuration

To configure a new Windows machine

```powershell
. .\windows.ps1
```

To install tools and dependencies

```powershell
. .\deps.ps1
```

# References

* jayharris/dotfiles-windows
