#!/bin/sh
#
# install.sh
# Copyright (C) 2016 real <real@gentoo-real>
#
# Distributed under terms of the MIT license.
#

HELPERS_FILE='../helpers/shell_helpers.sh'
[ ! -f "$HELPERS_FILE" ] && echo "shell_helpers file not found" && exit 1
source $HELPERS_FILE

is_var_empty $HOME && die '$HOME is empty.' 1

pushd $(dirname "$0") > /dev/null

mkdir -p $HOME/.vim/conf.d
call_install vimrc "$HOME/.vim"
call_install conf.d/* "$HOME/.zsh/conf.d"

popd > /dev/null

is_file_exists "$HOME/.vimrc" && backup_file "$HOME/.vimrc"
ln -s "$HOME/.vim/vimrc" "$HOME/.vimrc"
