#!/bin/bash
awk 'NR==3 {printf "%3.0f", ($3/70)*100}' /proc/net/wireless
