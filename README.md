# winfiles

PowerShell profile, installation and configuration tools for Windows.

Tested on:
* Windows 10, version 2004

**Note**: Very much an experimental, WIP, dangerous, and proof-of-concept repo.


# Installation

If required, run as admin

    # Set-ExecutionPolicy Bypass

To install without repository

```powershell
$source = "https://raw.github.com/andrejusk/winfiles/master/setup/install.ps1"

# Current PowerShell instance will exit
iex ((new-object net.webclient).DownloadString($source))
```

To install within repository

    $ . .\bootstrap.ps1

Run extra PowerShell commands on start-up by creating `extra.ps1`,
sample contents:

```
Set-Environment "USER_NAME"     "YOUR_NAME"
Set-Environment "USER_EMAIL"    "YOUR_EMAIL"
```


# CLI

After installing this repository, a CLI utility is available
to interact with the functionality provided by the repository:

    $ winfiles <action> <option>

Examples of actions and options available below.

## Configuration

To configure a new Windows machine (as admin)

    # winfiles config windows

To install tools and dependencies (as admin)

    # winfiles config deps

To login and import GPG key from keybase

    $ winfiles config pgp

To create a Hyper-V VM (as admin)

    # winfiles config hyper-v


# Repository Layout

* `components` &ndash;
Scripts to execute when starting a new PowerShell instance
(see [Microsoft.PowerShell_profile](Microsoft.PowerShell_profile.ps1))

* `config` &ndash;
Configuration scripts accessible using the `winfiles` CLI utility
(see [winfiles_functions](./components/03_winfiles_functions.ps1))

* `home` &ndash;
Tracked files for the $HOME folder

* `setup` &ndash;
Scripts for setting up repository

* `vscode` &ndash;
Tracked files for VSCode


# References

* jayharris/dotfiles-windows
