#!/bin/bash
setxkbmap -option caps:super
bluetoothctl power on
xset s 180 120 dpms 0 0 0
xss-lock -n /usr/bin/dim-screen.sh -l -- env XSECURELOCK_BLANK_TIMEOUT=1 XSECURELOCK_BLANK_DPMS_STATE='off' xsecurelock &
deadd-notification-center &
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
nitrogen --restore &
picom -b --experimental-backends &
dex -a &
echo 3 > /tmp/libinput_discrete_deltay_multiplier
uget-inegrator &
flameshot &
