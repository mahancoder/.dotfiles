PATH=$PATH:$HOME/.local/bin:$HOME/go/bin:$GOPATH/bin:$HOME/.dotnet/tools
XDG_DATA_DIRS="/var/lib/flatpak/exports/share:/home/mahan/.local/share/flatpak/exports/share:$XDG_DATA_DIRS"
if ! pgrep -u "$USER" ssh-agent > /dev/null; then
	    ssh-agent -t 1h > "$XDG_RUNTIME_DIR/ssh-agent.env"
fi
if [[ ! "$SSH_AUTH_SOCK" ]]; then
	    source "$XDG_RUNTIME_DIR/ssh-agent.env" >/dev/null
fi
