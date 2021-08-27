#!/bin/bash
# 
# Shell Script By
#  __       ______   ______   ______   ______   __  __
#    |            |        \        |        |    |   |
#    |        |__      |   |      |        |      |_  |
#    |           |     |   |      |        |          |
#    |___     |___     |_  |  __  |_       |     ___  |
#        |        |        |        |      |          | 
#
# This simple script attaches the first unattached tmux session,
# if there is one, or creates a new, if there isn't.

if tmux list-sessions | awk '$1 ~ ":" && $0 !~ "(attached)" {print $0}' | grep ""; then
    echo "attach" $(tmux list-sessions | awk '$1 ~ ":" && $0 !~ "(attached)" {print substr ($1, 1, 1)}' | awk 'NR==1{print $1}') 
    tmux attach-session -t $(tmux list-sessions | awk '$1 ~ ":" && $0 !~ "(attached)" {print substr ($1,1,1)}' | awk 'NR==1 {print $1}')
else
    echo "new"
    tmux new-session
fi
echo "Opening zsh"
zsh
