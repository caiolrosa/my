#!/bin/bash

regular=$(apt upgrade -s 2>/dev/null | awk '/^[0-9]+ upgraded/ {print $1}')
security=$(apt upgrade -s 2>/dev/null | awk '/^[0-9]+ .+ security/ {print $1}')
total=$(($regular + $security))

if [[ $security -gt 0 ]]; then
  echo "<fc=#bf616A><fn=2></fn>  $total updates</fc>"
elif [[ $total -gt 0 ]]; then
  echo "<fc=#d08770><fn=  $total updates</fc>"
else
  echo "<fc=#88c0d0><fn=2></fn>  $total updates</fc>"
fi
