#!/usr/bin/env zsh
#
# bindings.zsh
# Copyright (C) 2016 real <real93@live.ru>
#
# Distributed under terms of the MIT license.
#
# All bindings can be used in urxvt with tmux.
# Just urxvt has different bindings.
# To get key code you need to type 'cat' command and then press necessary key

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
