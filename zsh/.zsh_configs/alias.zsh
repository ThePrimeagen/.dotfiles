#!/usr/bin/env zsh

alias cppcompile='c++ -std=c++11 -stdlib=libc++'
alias vim=nvim
alias vi=nvim
alias pwgen="pwgen -y 15"
alias ls=exa
alias bazel=bazelisk
alias k=kubectl
alias grep="rg"
complete -F __start_kubectl k

alias cat=bat
alias curl=curlie
alias disable_screen='xrandr --output DP-3 --off'
alias enable_screen='autorandr --change'

## Ls Aliases (copied from common-aliases)
alias l='ls -lFh'     #size,show type,human readable
alias la='ls -lAFh'   #long list,show almost all,show type,human readable
alias lr='ls -tRFh'   #sorted by date,recursive,show type,human readable
alias lt='ls -ltFh'   #long list,sorted by date,show type,human readable
alias ll='ls -l'      #long list
alias ldot='ls -ld .*'
alias lS='ls -1FSsh'
alias lart='ls -1Fcart'
alias lrt='ls -1Fcrt'

