#!/usr/bin/env zsh
#
# .zshrc
# Copyright (C) 2016-2017 Vyacheslav Korepanov <real93@live.ru>
#
# Distributed under terms of the MIT license.
#

HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
# ctrl+w don't delete all to near space
WORDCHARS=''@""

fpath=(~/.zsh/completion $fpath)

zstyle ':completion:*' menu select
zstyle ':completion:*' rehash true
zstyle ':completion::complete:*' use-cache 1

autoload -U compinit promptinit colors
colors
compinit
promptinit #; prompt gentoo

##############################################################################
# Aliases
##############################################################################

# ls output with colors
if [ "$(uname)" = "Linux" ]; then
    alias ls='ls --color=auto --group-directories-first --classify'
else
    alias ls='ls -G'
fi

alias grep='grep --color=auto'

##############################################################################
# Bindings
##############################################################################

# emacs behaviour
bindkey -e
# delete
bindkey '^[[3~' delete-char
# home
bindkey '^[[1~' beginning-of-line
# end
bindkey '^[[4~' end-of-line
# up and down arrows - history search
bindkey '^[[A'  history-beginning-search-backward
bindkey '^[[B'  history-beginning-search-forward

##############################################################################
# Options
##############################################################################

# disable beeping
unsetopt beep

# history options
setopt appendhistory extendedhistory incappendhistory sharehistory\
    histignoredups histignorealldups histignorespace hist_reduce_blanks

# expansion and globbing options
setopt extendedglob
# cd options
setopt autocd
# initialisation options
setopt noallexport noglobalexport

##############################################################################
# Plugins, prompt, tmux.
##############################################################################
export PATH="$HOME/.local/bin:/root/.cargo/bin:$HOME/.cargo/bin:$HOME/.vim/bundle/fzf/bin:$HOME/.cabal/bin:$HOME/.ghcup/bin:$PATH"

export LIBVA_DRIVER_NAME=vdpau
export LIBVA_DRIVERS_PATH=/usr/lib/dri/

GIT_PROMPT_EXECUTABLE="haskell"
export ANTIGEN_HS_OUT="$HOME/.zsh/plugins/workdir"
source $HOME/.zsh/plugins/antigen-hs/init.zsh

local reset_prompt_font='%{$fg[default]%}%{$reset_color%}'
local last_status_prompt='%(0?.%{$fg[green]%}☺.%{$fg_bold[red]%}%?)%{$fg[blue]%}'$reset_prompt_font
local login_info_prompt='%{$fg[default]%}%(!.%{$fg[red]%}.%{$fg[green]%})%n@%M%{$fg[blue]%} %# '$reset_prompt_font
local cur_dir_prompt='%{$fg_bold[blue]%}%~'$reset_prompt_font
export PROMPT=$last_status_prompt' '$login_info_prompt
export RPROMPT=$cur_dir_prompt' $(git_super_status)'$reset_prompt_font

if [[ "$TERM" = dumb ]]; then
    unset zle_bracketed_paste
fi

export GPG_TTY="$(tty)"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export FZF_TMUX=1
export FZF_TMUX_HEIGHT='30%'
export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_R_OPTS="
  --preview 'echo {}' --preview-window up:3:hidden:wrap
  --bind 'ctrl-/:toggle-preview'
  --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'
  --color header:italic
  --header 'Press CTRL-Y to copy command into clipboard'"

export QT_QPA_PLATFORMTHEME="qt5ct"

function __setup_wayland_vars() {
    export MOZ_ENABLE_WAYLAND=1
    export QT_AUTO_SCREEN_SCALE_FACTOR=1
    export QT_QPA_PLATFORM=wayland
    export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
    export GDK_BACKEND=wayland
    export __GLX_VENDOR_LIBRARY_NAME=nvidia
    export WLR_NO_HARDWARE_CURSORS=1
    export GBM_BACKEND=nvidia-drm
    # export WLR_RENDERER=vulkan
    export GDK_DPI_SCALE=1.75
    export QT_SCALE_FACTOR=1.75
    export CHROMIUM_FLAGS="--enable-features=Vulkan --enable-features=VaapiVideoDecoder --enable-features=UseOzonePlatform --enable-gpu-rasterization --enable-zero-copy --ozone-platform=x11"
}

function run_sway() {
    __setup_wayland_vars
    exec dbus-run-session sway -V --unsupported-gpu
}

# startx if we login on tty6
[[ "$(tty)" = "/dev/tty1" ]] && exec startx
[[ "$(tty)" = "/dev/tty2" ]] && run_sway
# export __EGL_VENDOR_LIBRARY_FILENAMES=/usr/share/glvnd/egl_vendor.d/50_mesa.json

if [[ "$XDG_SESSION_TYPE" = "wayland" ]]; then
    __setup_wayland_vars
fi

if [ "$EUID" -ne 0 ] && [ -z "$TMUX" ] && [ -z "$SSH_TTY" ]; then
    tmux attach
fi

