#!/bin/bash
pactl set-sink-volume alsa_output.pci-0000_00_1b.0.analog-stereo 100%
setxkbmap -option caps:super
xset s 500 5 
xss-lock -n /usr/lib/xsecurelock/dimmer -l -- xsecurelock &
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
nitrogen --restore &
picom -b &
dex -a &
flameshot &
gtk-launch $(xdg-mime query default x-scheme-handler/http) &
