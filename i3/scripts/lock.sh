img=/tmp/i3lock.png

scrot -o $img
convert $img -scale 5% -scale 2000% $img

i3lock -i $img
