# Additional config + aliases specific to WSL

# Add wsl.exe and others to the path without enabling full interop
fish_add_path /mnt/c/Windows/System32

set -gx WIN_HOME (wslpath (cmd.exe /c "echo %USERPROFILE%" 2>/dev/null | string trim) 2>/dev/null)
set -gx APPDATA "$WIN_HOME/AppData"

set -l _win_workspace (wslpath "D:/Workspace" 2>/dev/null)
if test -d "$_win_workspace"
    set -gx WIN_WORKSPACE $_win_workspace
else
    set -gx WIN_WORKSPACE "$WIN_HOME/Workspace"
end

set -gx COLORTERM truecolor

abbr open-ps powershell.exe /c start
alias sp-open-wsl='powershell.exe /c start docs/_build/html/index.html'
alias cov-open-wsl='powershell.exe /c start test-reports/index.html'

# Use npiperelay to forward Windows SSH agent
set -gx SSH_AUTH_SOCK $HOME/.ssh/agent.sock

# Check if SSH agent socket is already active
if not command ss -a | grep -q $SSH_AUTH_SOCK
    # Clean up any stale socket
    rm -f $SSH_AUTH_SOCK

    # Set up npiperelay for SSH agent forwarding
    set -l npr_path (wslpath 'C:/npiperelay/npiperelay.exe')
    if test -f "$npr_path"
        setsid socat \
            UNIX-LISTEN:$SSH_AUTH_SOCK,fork \
            EXEC:"$npr_path -ei -s //./pipe/openssh-ssh-agent",nofork &
    else
        echo "Warning: npiperelay not found at $npr_path"
    end
end
