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

# Use npiperelay to forward Windows SSH agent
set -Ux SSH_AUTH_SOCK $HOME/.ssh/agent.sock
command ss -a | grep -q $SSH_AUTH_SOCK
if test $status -ne 0
    rm -f $SSH_AUTH_SOCK
    set npiperelaypath $(wslpath "C:/npiperelay")
    setsid socat UNIX-LISTEN:$SSH_AUTH_SOCK,fork \
        EXEC:"$npiperelaypath/npiperelay.exe -ei -s //./pipe/openssh-ssh-agent" nofork &
end
