Set-Environment "EDITOR" "code"
Set-Environment "GIT_EDITOR" $Env:EDITOR

Set-Environment "WORKSPACE" "$HOME/workspace"
New-Item $env:WORKSPACE -ItemType Directory -Force -ErrorAction SilentlyContinue | Out-Null
