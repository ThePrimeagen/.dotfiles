#!/usr/bin/env bash

PAGER="less -r"
selected=$(cat ~/.tmux-cht-languages ~/.tmux-cht-command | fzf)

if [[ -z $selected ]]; then
    exit 0
fi

# -e Let you use arrow keys to correct query
# -r Prevent \ to escape charecters
read -rep "Enter Query: " query

if grep -qs "$selected" ~/.tmux-cht-languages; then
    curl -s "cht.sh/$selected/${query//\ /\+}" | $PAGER
else
    # Allow empty query search
    if [[ -n $query ]]; then
        curl -s "cht.sh/$selected~$query" | $PAGER
    else
        curl -s "cht.sh/$selected" | $PAGER
    fi
fi
