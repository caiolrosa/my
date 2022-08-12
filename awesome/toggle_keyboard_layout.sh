#!/bin/bash

(setxkbmap -query | grep -q "layout:\s\+us") && setxkbmap br || setxkbmap us

