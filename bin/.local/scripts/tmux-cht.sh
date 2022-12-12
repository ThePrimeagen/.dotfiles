#!/usr/bin/env bash

# Prerequisites:
# - fuzzy finder: either fzf or sk
# - bat: as cat replacement - is being used as pager inside nvim terminal

fuzzy_finder=fzf  # use either fzf or sk

nvim_options="\
    -c \"nnoremap i :echo 'i disabled!'<CR>\" \
    -c \"nnoremap I :echo 'I disabled!'<CR>\" \
    -c \"nnoremap a :echo 'a disabled!'<CR>\" \
    -c \"nnoremap A :echo 'A disabled!'<CR>\" \
    -c \"nnoremap p :echo 'p disabled!'<CR>\" \
    -c \"nnoremap P :echo 'P disabled!'<CR>\" \
    -c \"nnoremap q :q!<CR>\""

# Using bat inside the terminal results in line wraps to dynamically adjust
# when changing the windown size
bat_options="\
    --paging=always \
    --style=plain"

selected=$(cat ~/.config/tmux/.tmux-cht-languages ~/.config/tmux/.tmux-cht-command | $fuzzy_finder)

if [[ -z $selected ]]; then
    exit 0
fi

read -p "Enter Query: " query

if grep -qs "$selected" ~/.config/tmux/.tmux-cht-languages; then
    query=$(echo "$query" | tr ' ' '+')
    url="cht.sh/$selected/$query"
else
    url="cht.sh/$selected~$query"
fi

tmux neww -n "$url" bash -c "nvim $nvim_options \
    +'ter curl --no-progress-meter $url | bat $bat_options'"
