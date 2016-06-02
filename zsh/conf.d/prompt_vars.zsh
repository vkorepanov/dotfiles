#!/usr/bin/env zsh
#
# prompt_vars.zsh
# Copyright (C) 2016 real <real93@live.ru>
#
# Distributed under terms of the MIT license.
#

# tty
export TTY_SHORT='%l'
export TTY_FULL='%y'
# local machine parameters
export MACHINE_HOSTNAME_FULL='%M'
export MACHINE_HOSTNAME_SHORT='%m'
export USER_NAME='%n'
# '%' if not root, otherwise '#'
export PRIVILEGES_SIGN='%#'

export LAST_RETURN_STATUS='%?'
# current direcrory, starts with '/'
export CURRENT_DIR_FULL='%/' # same as '%d'
# if current directory starts with $HOME, that part is replaced by a '~'
export CURRENT_DIR_REPLACE_HOME='%~'

export HISTORY_EVENT_NUMBER='%h' # same as '%!'
export JOBS_COUNT='%j'

# the date in yy-mm-dd format
export CURRENT_DATE='%D'
# current time of day in 24h format
export CURRENT_TIME_24='%T'
# current time of day, in 12h, am/pm format
export CURRENT_TIME_12='%t' # same as '%@'
# current time of day in 24h format, with seconds
export CURRENT_TIME_24_SECS='%*'
# string after used to get date or time, which formatted using the strftime function
export CURRENT_DATETIME_STRFTIME='%D'

# start and stop boldface mode
export BOLD_START='%B'
export BOLD_STOP='%b'
# clear to the end of line
export CLEAR_TO_EOL='%E'
# start and stop underline mode
export UNDERLINE_START='%U'
export UNDERLINE_STOP='%u'
# start and stop standout mode
export STANDOUT_START='%S'
export STANDOUT_STOP='%s'
# start and stop using different foreground (if term is supported)
export FOREGROUND_START='%F'
export FOREGROUND_STOP='%f'
# start and stop using different background (if term is supported)
export BACKGROUND_START='%K'
export BACKGROUND_STOP='%k'
