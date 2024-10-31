#!/bin/bash

MON="eDP-1"    # Discover monitor name with: xrandr | grep " connected"
STEP=5          # Step Up/Down brightnes by: 5 = ".05", 10 = ".10", etc.

CurrBright=$( xrandr --verbose --current | grep ^"$MON" -A5 | tail -n1 )
CurrBright="${CurrBright##* }"  # Get brightness level with decimal place
CurrBrightInt=$(echo $CurrBright*100/1 | bc)

MathBright="$CurrBrightInt"

[[ "$1" == "up" ]] && MathBright=$(( MathBright + STEP ))
[[ "$1" == "down" ]] && MathBright=$(( MathBright - STEP ))
[[ "${MathBright:0:1}" == "-" ]] && MathBright=0    # Negative not allowed
[[ "$MathBright" -gt 100  ]] && MathBright=100      # Can't go over 1.00

NewBright=$(echo "scale=2; $MathBright/100" | bc)

xrandr --output "$MON" --brightness "$NewBright"   # Set new brightness

# Display current brightness
printf "Monitor $MON "
echo $( xrandr --verbose --current | grep ^"$MON" -A5 | tail -n1 )
