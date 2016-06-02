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

mkdir -p $HOME/.zsh/conf.d
call_install zshrc zlogin "$HOME/.zsh"
call_install conf.d/* "$HOME/.zsh/conf.d"

popd > /dev/null

is_file_exists "$HOME/.zshrc" && backup_file "$HOME/.zshrc"
ln -s "$HOME/.zsh/zshrc" "$HOME/.zshrc"

is_file_exists "$HOME/.zlogin" && backup_file "$HOME/.zlogin"
ln -s "$HOME/.zsh/zlogin" "$HOME/.zlogin"
