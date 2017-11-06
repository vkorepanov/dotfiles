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

mkdir -p $HOME/.tmux
safe_symlink *.conf "$HOME/.tmux"

popd > /dev/null

is_exists "$HOME/.tmux.conf" && backup_file "$HOME/.tmux.conf"
ln -s "$HOME/.tmux/tmux.conf" "$HOME/.tmux.conf"

