#!/bin/sh

if [ -f ~/.Xresources ]; then
    xrdb ~/.Xresources
fi

exec dbus-launch stack run --stack-yaml /home/real/.config/xmonad/stack.yaml xmonad
