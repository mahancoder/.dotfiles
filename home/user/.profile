PATH=$PATH:$HOME/.local/bin:$HOME/go/bin:$HOME/.dotnet/tools
export GOPATH="$HOME/go"
XDG_DATA_DIRS="/var/lib/flatpak/exports/share:/home/mahan/.local/share/flatpak/exports/share:$XDG_DATA_DIRS"
export BROWSER=brave
#export LIBVA_DRI3_DISABLE=1
xrandr --output HDMI-2 --off --output eDP-1 --auto --output HDMI-1 --auto --left-of eDP-1 --primary
#xrandr --output HDMI-2 --off --output eDP-1 --auto --primary --output HDMI-1 --off
if ! pgrep -u "$USER" ssh-agent > /dev/null; then
	    ssh-agent -t 1h > "$XDG_RUNTIME_DIR/ssh-agent.env"
fi
if [[ ! "$SSH_AUTH_SOCK" ]]; then
	    source "$XDG_RUNTIME_DIR/ssh-agent.env" >/dev/null
fi
