<#
.SYNOPSIS
  Import keybase keys to gpg keyring
#>


keybase login
keybase pgp export | gpg --import
keybase pgp export --secret | gpg --import --allow-secret-key-import
