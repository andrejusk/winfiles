<#
.SYNOPSIS
    Login to keybase and import pgp key
#>

keybase login
keybase pgp export | gpg --import
keybase pgp export --secret | gpg --import --allow-secret-key-import
