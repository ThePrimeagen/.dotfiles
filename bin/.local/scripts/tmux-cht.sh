#!/usr/bin/env bash

# Prerequisites:
# - fuzzy finder: either fzf or sk

fuzzy_finder=fzf  # use either fzf or sk

# Pressing <esc> exits terminal mode and moves cursor to the middle of the screen
# Pressing q quits nvim inside normal and terminal mode
nvim_options="\
    -c \"nnoremap q :q!<CR>\" \
    -c \"tnoremap <esc> :<C-\\><C-n>M\" \
    -c \"tnoremap q :<C-\\><C-n>:q!<CR>\" \
    "

less_options="-R"

selected=$(cat \
    ~/.config/tmux/.tmux-cht-languages \
    ~/.config/tmux/.tmux-cht-command | \
    $fuzzy_finder)

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
    +'ter curl --no-progress-meter $url | less $less_options'"  # +'call feedkeys(\"i\")'"
