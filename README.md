# winfiles

PowerShell profile, installation and configuration tools for Windows

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

# Repository Layout

* `components` &ndash;
Scripts to execute when starting a new PowerShell instance
(see [Microsoft.PowerShell_profile](Microsoft.PowerShell_profile.ps1))

* `config` &ndash;
Configuration scripts accessible using the `winfiles` CLI utility
(see [winfiles](./components/03_winfiles_functions.ps1))

* `home` &ndash;
Tracked files for the $HOME folder

* `setup` &ndash;
Scripts for setting up repository

* `vscode` &ndash;
Tracked files for VSCode

# Configuration

To configure a new Windows machine

```powershell
winfiles script windows
```

To install tools and dependencies

```powershell
winfiles script deps
```

# References

* jayharris/dotfiles-windows
