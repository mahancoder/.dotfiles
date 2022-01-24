eval $(go env)
GOPATH=$GOPATH
PATH=$PATH:$HOME/.local/bin:$HOME/go/bin:$GOPATH/bin:$HOME/.dotnet/tools
if ! pgrep -u "$USER" ssh-agent > /dev/null; then
	    ssh-agent -t 1h > "$XDG_RUNTIME_DIR/ssh-agent.env"
fi
if [[ ! "$SSH_AUTH_SOCK" ]]; then
	    source "$XDG_RUNTIME_DIR/ssh-agent.env" >/dev/null
fi
