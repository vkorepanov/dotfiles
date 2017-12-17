#!/bin/sh
#
# install.sh
# Copyright (C) 2016-2017 Vyacheslav Korepanov <real@gentoo-real>
#
# Distributed under terms of the MIT license.
#

HELPERS_FILE='../helpers/shell_helpers.sh'
[ ! -f "$HELPERS_FILE" ] && echo "shell_helpers file not found" && exit 1
source $HELPERS_FILE

is_var_empty $HOME && die '$HOME is empty.' 1

mkdir -p "$HOME/.zsh/plugins/workdir"
script_dir="$PWD/$(dirname $0)"
safe_symlink "$script_dir/../.zshrc" "$HOME/.zshrc"
plugins_dir="$HOME/.zsh/plugins"
safe_symlink "$script_dir/MyAntigen.hs" "$plugins_dir/MyAntigen.hs"

old_pwd="$PWD"
antigen_hs_dir="$plugins_dir/antigen-hs"
if [ -e "$antigen_hs_dir" ]; then
    cd "$antigen_hs_dir"
    git fetch && git rebase origin/master
else
    cd "$plugins_dir"
    git clone https://github.com/Tarrasch/antigen-hs
fi

cd "$antigen_hs_dir"
stack setup
stack install
cd "$old_pwd"
