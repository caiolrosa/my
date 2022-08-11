#!/bin/bash
iwconfig $1 | grep -i quality | awk '{printf $2}' | awk -F '=' '{printf $2}' | awk -F '/' '{printf "%.0f", ($1/$2)*100}'
