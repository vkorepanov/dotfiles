#!/bin/bash

set -e

make_path() {
    local path="$1"
    if [ -e "$path" ]; then
        if [ -d "$path" ]; then
            return 0
        else
            echo "Can't create directory \"$path\": file exists" >&2
            return 1
        fi
    else
        mkdir -p "$HOME/.tmux/plugins"
    fi
}

make_link() {
    local src="$1"
    local dst="${2:-$src}"
    ln -fs "$PWD/$src" "$HOME/$dst"
}

main() {
    cd "$(dirname -- $0)"

    local links_only=""
    while getopts "s" opt; do
        case "$opt" in
            s) links_only=1;;
            *) echo "Unrecognized option: $opt" && return 1
        esac
    done

    make_path "$HOME/.tmux/plugins"
    make_path "$HOME/.vim/bundle"
    make_path "$HOME/.vim/swap"
    make_path "$HOME/.xmonad"
    make_path "$HOME/.zsh/plugins"

    if [ -z "$links_only" ]; then
        git clone https://github.com/Tarrasch/antigen-hs "$HOME/.zsh/plugins/antigen-hs"
        git clone https://github.com/VundleVim/Vundle.vim "$HOME/.vim/bundle/Vundle.vim"
        git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
    fi

    make_link .Xresources
    make_link .mplayer
    make_link .stalonetrayrc
    make_link .vimpcrc
    make_link .vimrc
    make_link .xinitrc
    make_link .xmobarrc
    make_link .zshrc
    make_link tmux/tmux.conf .tmux.conf
    make_link xmonad/xmonad.hs .xmonad/xmonad.hs
    make_link zsh/MyAntigen.hs .zsh/plugins
}

main "$@"
