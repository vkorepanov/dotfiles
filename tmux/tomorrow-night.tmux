# Color key:
#   #1d1f21 Background
#   #282a2e Current Line
#   #373b41 Selection
#   #c5c8c6 Foreground
#   #969896 Comment
#   #cc6666 Red
#   #de935f Orange
#   #f0c674 Yellow
#   #b5bd68 Green
#   #8abeb7 Aqua
#   #81a2be Blue
#   #b294bb Purple

set -g status-bg default
setw -g window-status-current-style bg="#282a2e",fg="#81a2be"

set-window-option -g window-status-style bg=default,fg=white
set-window-option -g window-status-format '#[fg=#6699cc,bg=colour235] #I #[fg=#999999,bg=#2d2d2d] #W #[default]'

set-window-option -g window-status-current-style none
set-window-option -g window-status-current-format '#[fg=#f99157,bg=#2d2d2d] #I #[fg=#cccccc,bg=#393939] #W #[default]'

# Windows are transparent by default.
setw -g window-style 'bg=default'
#setw -g window-active-style 'bg=#1d1f21'
setw -g window-active-style 'bg=default'
setw -g pane-active-border-style ''

setw -g window-status-activity-style fg="#8abeb7",bg="#1d1f21"

set -g pane-active-border-style bg=default,fg="#373b41"
set -g pane-border-style bg=default,fg="#373b41"

set -g message-style bg="#8abeb7",fg="#000000"

set -g message-command-style bg="#8abeb7",fg="#000000"

set -g message-style bg="#2d2d2d",fg="#cc99cc"

set -g mode-style bg="#1d1f21",fg="#de935f"

set -g status-right-style fg=black,bold
set -g status-right '#[fg=#8abeb7,bg=#2d2d2d] #T #[fg=#f99157,bg=#2d2d2d] %H:%M |#[fg=#6699cc] %y.%m.%d '

set -g pane-border-style bg=default,fg="#999999"
set -g pane-active-border-style fg="#f99157"

set -g clock-mode-colour "#81a2be"
set -g clock-mode-style 24
