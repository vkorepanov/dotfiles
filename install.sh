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
        mkdir -p "$path"
    fi
}

make_link_in_home() {
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
        git clone https://github.com/Tarrasch/antigen-hs "$HOME/.zsh/plugins/antigen-hs" || true
        git clone https://github.com/VundleVim/Vundle.vim "$HOME/.vim/bundle/Vundle.vim" || true
        git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm" || true
    fi

    make_link_in_home .Xresources
    make_link_in_home .mplayer
    make_link_in_home .stalonetrayrc
    make_link_in_home .vimpcrc
    make_link_in_home .vimrc
    make_link_in_home .xinitrc
    make_link_in_home .xmobarrc
    make_link_in_home .zshrc
    make_link_in_home alacritty/alacritty.yml .config/alacritty/alacritty.yml
    make_link_in_home gtk-3.0 .config/gtk-3.0
    make_link_in_home tmux/tmux.conf .tmux.conf
    make_link_in_home xmonad/xmonad.hs .xmonad/xmonad.hs
    make_link_in_home zsh/MyAntigen.hs .zsh/plugins
}

main "$@"
