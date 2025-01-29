# Additional config + aliases specific to WSL

# TODO: Use WSLENV envar instead
# export HOME_WIN=(wslpath (wslvar USERPROFILE))
export APPDATA="$HOME_WIN/AppData"
export WORKSPACE_WIN='/mnt/d/workspace'
export COLORTERM=truecolor

abbr open-ps powershell.exe /c start
alias sp-open-wsl='powershell.exe /c start docs/_build/html/index.html'
alias cov-open-wsl='powershell.exe /c start test-reports/index.html'

# Start Docker daemon automatically when logging in if not running.
wsl.exe -u root -e sh -c "service docker status > /dev/null || service docker start"
