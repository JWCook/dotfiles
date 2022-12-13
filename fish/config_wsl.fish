# Additional config + aliases specific to WSL

# TODO: Use WSLENV envar instead
# export HOME_WIN=(wslpath (wslvar USERPROFILE))
export APPDATA="$HOME_WIN/AppData"
export WORKSPACE_WIN='/mnt/d/workspace'

abbr open-ps powershell.exe /c start
alias sp-open-wsl='powershell.exe /c start docs/_build/html/index.html'
alias cov-open-wsl='powershell.exe /c start test-reports/index.html'
