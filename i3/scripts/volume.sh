#!/bin/bash

m=$(pactl get-sink-mute @DEFAULT_SINK@)
v=$(pactl get-sink-volume @DEFAULT_SINK@ | awk -F '/' '{print $4}');

echo $v;
