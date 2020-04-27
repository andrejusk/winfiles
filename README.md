# winfiles

PowerShell profile, installation and configuration tools for Windows

# Installation

If required, run as admin

```powershell
Set-ExecutionPolicy Unrestricted
```

To install without repository

```powershell
$source = "https://raw.github.com/andrejusk/winfiles/master/setup/install.ps1"
iex ((new-object net.webclient).DownloadString($source))
```

To install within repository

```powershell
. .\bootstrap.ps1
```

# CLI

After installing this repository, a CLI utility is available 
to interact with the tools provided by the repository. 
It can be used as:

    $ winfiles <action> <option>

Examples of actions and options available below.

## Configuration

To configure a new Windows machine (as admin)

    # winfiles config windows

To install tools and dependencies (as admin)

    # winfiles config deps

To login and import GPG key from keybase

    $ winfiles config pgp

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


# References

* jayharris/dotfiles-windows
