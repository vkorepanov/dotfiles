#!/bin/sh

if [ -f ~/.Xresources ]; then
    xrdb ~/.Xresources
fi

# Test compton with GLX interface. With nvidia it didn't work properly :(
# compton
#   -D 5        # Fade effect, ms
#   -m 0.9      # Opacity for dropdown and popup menus.
#   -c          # Enable shadows.
#   -C          # Avoid shadows on dock/panel windows.
#   -f          # Fade windows in/out when opening/closing
#   -i 0.85     # Opacity of inactive windows.
#   -G          # No shadows on dnd windows.
#   -b          # Daemonize.
#   --shadow-blue 0.15
#   --inactive-dim 0.3
#   --vsync opengl-mswc
#   --paint-on-overlay
#   --sw-opti
#   --backend glx
#   --glx-no-stencil
#   --glx-no-rebind-pixmap
#   --glx-swap-method buffer-age
#   --glx-use-gpushader4

exec ck-launch-session xmonad

