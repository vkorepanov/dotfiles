#!/bin/sh
#
# shell_helpers.sh
# Copyright (C) 2016 real <real@gentoo-real>
#
# Distributed under terms of the MIT license.
#
# This file contains wrappers and helpers which can be used in shell scripts.

## \brief Function returns true if variable is empty.
## \param $1 Variable.
is_var_empty() {
    [ -z "$1" ] && return 0 || return 1
}

## \brief Function returns true if the file exists.
## \param $1 Name of the file.
## \note If $1 is directory, result will be false (return 1).
is_exists() {
    [ -e "$1" ] && return 0 || return 1
}

## \brief Function calls 'echo' and redirect its output to stderr.
## \param $@ String to print.
echoer() {
    echo "$@" >&2
}

## \brief Function shows an error message and then calls 'exit'.
## \param $1 Error message.
## \param $2 Exit code. 0 is the default value.
die() {
    local MSG="$1"
    local EXIT_CODE="$2"

    [ -n "$MSG" ] && echoer $MSG
    [ -n "$EXIT_CODE" ] && exit $EXIT_CODE || exit 0
}

## \brief Function makes a symbolic link.
##
## \param $1 Source file.
## \param $2 Destination link name.
## \note If a destination link file exists, it will be backuped.
safe_symlink() {
    [ $# -ne 2 ] && return
    local src="$1"
    local dst="$2"
    is_exists "$dst" && backup_file "$dst"
    ln -s "$src" "$dst"
}

## \brief Function makes backup of the file.
## \param $1 Name of the file.
##
## Old file will be renamed.
## If "<filename>.old" doesn't exists, then it will be new name of the file.
## If exists, then will be found first possible name of the file with number
## at the end. Examples: <filename>.old1, <filename>.old5, etc.
backup_file() {
    local FILENAME="$1"
    is_exists "$FILENAME" || return 0
    local f="$FILENAME"
    local extension=".old"
    local i=""
    while is_exists "$f$extension$i"; do
        i=$((i + 1))
        echo $i
    done
    local NEW_FILENAME="$f$extension$i"
    echo "$FILENAME saved as $NEW_FILENAME"
    mv "$FILENAME" "$NEW_FILENAME"
}

