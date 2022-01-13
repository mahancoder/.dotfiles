#!/bin/bash
setxkbmap -option caps:super
bluetoothctl power on
xbacklight -set 60
xset s 180 120 
xss-lock -n /usr/bin/dim-screen.sh -l -- xsecurelock &
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
nitrogen --restore &
picom -b &
dex -a &
uget-inegrator &
flameshot &
gtk-launch $(xdg-mime query default x-scheme-handler/http) &
