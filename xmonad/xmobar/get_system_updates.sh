#!/bin/bash

total=$(checkupdates | wc -l)
if [[ $total -eq 0 ]]; then
  echo "<fc=#81a1c1><fn=2></fn>  $total updates</fc>"
else
  echo "<fc=#ebcb8b><fn=2></fn>  $total updates</fc>"
fi
