#!/bin/bash
#
# getVolume.sh
# Copyright (C) 2023 Vyacheslav Korepanov <real93@live.ru>
#
# Distributed under terms of the MIT license.
#

device="${1:-alsa_output.pci-0000_0b_00.3.analog-stereo}"

pactl list sinks | grep -A10 "$device" | head -n10 | grep Volume | head -n1 | grep -o '[0-9]*%' | head -n1 | sed -e 's/%//'
