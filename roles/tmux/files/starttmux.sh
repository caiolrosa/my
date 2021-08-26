#!/bin/bash
session="dev"

tmux start-server
tmux new-session -d -s $session

tmux select-window -t $session:0
tmux rename-window nvim

tmux new-window -t $session:1 -n dev

tmux new-window -t $session:2 -n task
tmux select-window -t $session:2
tmux send-keys -t $session:2 "taskwarrior-tui" ENTER

tmux select-window -t $session:0

tmux attach-session -t $session
