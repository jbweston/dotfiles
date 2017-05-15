#!/bin/bash

tmpbg='/tmp/screen.png'

scrot "$tmpbg"

convert "$tmpbg" -scale 10% -scale 1000% "$tmpbg"
composite -gravity center "$tmpbg" "$tmpbg"

# clock out of project
current_project="$(t cur)"
[ "$current_project" ] && t out

#enable i3lock with colours & modified image
i3lock  -i "$tmpbg" --nofork &
wait

# clock back in to project
[ "$current_project" ] && t in

#clean up
rm "$tmpbg"
