#!/bin/bash
xrandr --output HDMI2 --off --output eDP1 --auto --output HDMI1 --auto --left-of eDP1 --primary
setxkbmap -option caps:super
bluetoothctl power on
xset s 180 120 
xss-lock -n /usr/bin/dim-screen.sh -l -- xsecurelock &
deadd-notification-center &
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
nitrogen --restore &
picom -b &
dex -a &
uget-inegrator &
flameshot &

