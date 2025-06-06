# Additional config + aliases specific to WSL
set -gx WIN_HOME (wslpath "C:/Users/$USER")
set -gx WIN_WORKSPACE (wslpath 'D:/workspace')
set -gx APPDATA "$WIN_HOME/AppData"
set -x COLORTERM truecolor

abbr open-ps powershell.exe /c start
alias sp-open-wsl='powershell.exe /c start docs/_build/html/index.html'
alias cov-open-wsl='powershell.exe /c start test-reports/index.html'

# Start Docker daemon automatically when logging in if not running.
wsl.exe -u root -e sh -c 'service docker status > /dev/null || service docker start'

# Use npiperelay to forward Windows SSH agent
set -Ux SSH_AUTH_SOCK $HOME/.ssh/agent.sock
command ss -a | grep -q $SSH_AUTH_SOCK
if test $status -ne 0
    rm -f $SSH_AUTH_SOCK
    set npr_path (wslpath 'C:/npiperelay/npiperelay.exe')
    setsid socat \
        UNIX-LISTEN:$SSH_AUTH_SOCK,fork \
        EXEC:"$npr_path -ei -s //./pipe/openssh-ssh-agent",nofork &
end
