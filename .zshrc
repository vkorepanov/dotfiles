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

zstyle ':completion:*' menu select
zstyle ':completion:*' rehash true
zstyle ':completion::complete:*' use-cache 1

autoload -U compinit promptinit colors
colors
compinit
promptinit; prompt gentoo

##############################################################################
# Aliases
##############################################################################

# ls output with colors, directories first, with indicators
alias ls='ls --color=auto --group-directories-first --classify'
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

GIT_PROMPT_EXECUTABLE="haskell"
export ANTIGEN_HS_OUT="$HOME/.zsh/plugins/workdir"
source $HOME/.zsh/plugins/antigen-hs/init.zsh

# 3 strings prompt:
# 1) Status code of last executed command.
# 2) Current directory and git status info.
# 3) user@host info.
export PROMPT=$'%{$fg[blue]%}
┌─────────────────%(0?.%{$fg[green]%}☺.%{$fg_bold[red]%}%?)%{$fg[blue]%}
├ %{$fg_bold[blue]%}%~ %{$fg[default]%}$(git_super_status)%{$fg[blue]%}
└─%(!.%{$fg[red]%}.%{$fg[green]%})%n@%M%{$fg[blue]%} %#%{$fg[default]%}%{$reset_color%} '

export PATH="$PATH:$HOME/.local/bin:/root/.cargo/bin"

# startx if we login on tty6
[[ "$(tty)" = "/dev/tty6" ]] && exec startx

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

FZF_TMUX=1
FZF_TMUX_HEIGHT='30%'

if [ -z "$TMUX" ]; then
    tmux attach
fi

