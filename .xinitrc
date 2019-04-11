#!/bin/sh

if [ -f ~/.Xresources ]; then
    xrdb ~/.Xresources
fi

pulseaudio --start

exec dbus-launch xmonad
