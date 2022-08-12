#!/bin/bash
session="dev"

tmux start-server
tmux new-session -d -s $session

tmux select-window -t $session:0
tmux rename-window nvim
tmux send-keys -t $session:0 "nvim" ENTER

tmux new-window -t $session:1 -n dev

tmux select-window -t $session:0

tmux attach-session -t $session
