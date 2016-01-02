#!/usr/bin/env zsh
#
# options.zsh
# Copyright (C) 2016 real <real93@live.ru>
#
# Distributed under terms of the MIT license.
#

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

