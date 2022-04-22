PATH=$PATH:$HOME/.local/bin:$HOME/go/bin:$GOPATH/bin:$HOME/.dotnet/tools
XDG_DATA_DIRS="/var/lib/flatpak/exports/share:/home/mahan/.local/share/flatpak/exports/share:$XDG_DATA_DIRS"
BROWSER=brave
CLR_ICU_VERSION_OVERRIDE=$(pacman -Q icu | awk '{split($0,a," ");print a[2]}' | awk '{split($0,a,"-");print a[1]}')
xrandr --output HDMI2 --off --output eDP1 --auto --output HDMI1 --auto --left-of eDP1 --primary
if ! pgrep -u "$USER" ssh-agent > /dev/null; then
	    ssh-agent -t 1h > "$XDG_RUNTIME_DIR/ssh-agent.env"
fi
if [[ ! "$SSH_AUTH_SOCK" ]]; then
	    source "$XDG_RUNTIME_DIR/ssh-agent.env" >/dev/null
fi
