#!/bin/sh

if [ -f ~/.Xresources ]; then
    xrdb ~/.Xresources
fi

xsetroot -cursor_name left_ptr
feh --bg-center .background_image
# Compositing effects. Works fine with nvidia driver 355.11 (GTX 460 card).
compton -bcCf -i 0.8 -D 0 --shadow-blue 0.15 --inactive-dim 0.3 \
    --paint-on-overlay --unredir-if-possible --backend glx --glx-no-stencil \
    --glx-no-rebind-pixmap --vsync opengl-swc

numlockx
xscreensaver &
skype &
nvidia-settings &
ksysguard &
stalonetray &
chromium &
steam &
# Xmobar has transparency (200/255). Stalonetray needs to be transparent too.
sleep 1 && transset -n stalonetray 0.784314 &

exec ck-launch-session xmonad

