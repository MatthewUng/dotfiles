#!/bin/bash

set -x

SESSION="main"

setup_window(){
    DIR=$1

    tmux send-keys "cd $DIR" 'C-m' 'nvim' 'C-m'

    tmux select-pane -t 0
    tmux split-window -h
    tmux select-pane -t 1
    tmux resize-pane -R 40
    tmux send-keys "cd $DIR" 'C-m'

    tmux split-window -v
    tmux select-pane -t 2
    tmux send-keys "cd $DIR" 'C-m'

    tmux split-window -v
    tmux select-pane -t 3
    tmux send-keys "cd $DIR" 'C-m'
}

tmux has-session -t $SESSION
if [ $? -eq 0 ]
then
    tmux attach-session -t $SESSION
else
    # create session
    tmux new-session -d -s $SESSION 

    # create first window
    tmux select-window -t $SESSION:1
    setup_window 'dir'
    tmux send-keys 'git s' 'C-m'

    # create second window
    tmux new-window
    tmux select-window -t $SESSION:2
    setup_window 'dir'

    tmux select-window -t $SESSION:1
    tmux select-pane -t 0
    tmux attach
fi
