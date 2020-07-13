# winfiles

PowerShell profile, installation and configuration tools for Windows.

Tested on:
* Windows 10, version 2004


## Installation

If required, run as admin

    # Set-ExecutionPolicy Bypass

To install without repository

```powershell
$source = "https://raw.github.com/andrejusk/winfiles/master/install.ps1"

# Current PowerShell instance will exit
iex ((new-object net.webclient).DownloadString($source))
```

To install from within repository

    $ . .\bootstrap.ps1


## CLI

After installing this repository, a CLI utility is available
to interact with the functionality provided by the repository:

    $ winfiles <action> <option>

To perform all Windows and Chocolatey updates (as admin)

    # winfiles update

To configure a new Windows machine
including privacy, and performance defaults [[1]]:

    # winfiles config windows

To install/update tools and dependencies
using [Chocolatey](https://chocolatey.org/):

    # winfiles config deps

To create a Hyper-V VM (WIP)

    # winfiles config hyper-v


## Repository Layout

* `components` &ndash;
Scripts to execute when starting a new PowerShell instance
(see [Microsoft.PowerShell_profile](Microsoft.PowerShell_profile.ps1))

* `config` &ndash;
Configuration scripts accessible using the `winfiles` CLI utility
(see [winfiles_functions](components/03_winfiles_functions.ps1))

* `files` &ndash;
Tracked files for bootstrap installer
(see [bootstrap.json](bootstrap.json))


## References

[1]: https://github.com/jayharris/dotfiles-windows
[[1]] - jayharris/dotfiles-windows
