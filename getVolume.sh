#!/bin/bash
#
# getVolume.sh
# Copyright (C) 2023 Vyacheslav Korepanov <real93@live.ru>
#
# Distributed under terms of the MIT license.
#

device="${1:-@DEFAULT_AUDIO_SINK@}"

wpctl get-volume "$device" | grep -o '[0-9.]*' | awk '{print($1 * 100);}'
