#!/bin/bash

volume=$(amixer get Master | awk -F'[]%[]' '/%/ {if ($7 == "off") { print "Muted" } else { print $2 }}' | head -n 1)

echo $volume

exit 0
