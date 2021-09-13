#!/usr/bin/env bash
selected=`cat ~/.tmux-cht-languages ~/.tmux-cht-command | fzf`
read -p "Enter Query: " query

if grep -qs "$selected" ~/.tmux-cht-languages; then
    query=`echo $query | tr ' ' '+'`
    echo "curl cht.sh/$selected/$query & while [ : ]; do sleep 1; done"
    tmux neww bash -c "curl cht.sh/$selected/$query & while [ : ]; do sleep 1; done"
else
    echo "curl cht.sh/$selected~$query & while [ : ]; do sleep 1; done"
    tmux neww bash -c "curl cht.sh/$selected~$query & while [ : ]; do sleep 1; done"
fi

