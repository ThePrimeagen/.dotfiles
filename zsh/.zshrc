# export ZSH=$HOME/.oh-my-zsh
# Plugin Configuration
source /usr/local/share/antigen/antigen.zsh

CONFIG_DIR=$HOME/.zsh_configs
# Use Antigen for plugin management
antigen use oh-my-zsh

# Apply Themes
# antigen theme bureau
antigen theme romkatv/powerlevel10k

# Plugins
antigen bundle aws
antigen bundle autojump
antigen bundle ansible
antigen bundle brew
antigen bundle command-not-found
antigen bundle compleat
antigen bundle docker
antigen bundle docker-compose
antigen bundle encode64
antigen bundle extract
antigen bundle fzf
antigen bundle git
antigen bundle git-extras
antigen bundle git-flow
antigen bundle golang
antigen bundle jsontools
antigen bundle python
antigen bundle pyenv
antigen bundle pip
antigen bundle ripgrep
antigen bundle tmux
antigen bundle vagrant
antigen bundle vault
antigen bundle rupa/z
antigen bundle zsh-navigation-tools
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-completions
antigen bundle zsh-users/zsh-autosuggestions

antigen apply

[ -f $CONFIG_DIR/exports.zsh ] && source $CONFIG_DIR/exports.zsh
[ -f $CONFIG_DIR/env.zsh ] && source $CONFIG_DIR/env.zsh
# ---[ Extras ]-------------------------------------------------------
source <(kubectl completion zsh)
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


# To customize prompt, run `p10k configure` or edit ~/.dotfiles/zsh/.p10k.zsh.
[[ ! -f $CONFIG_DIR/.p10k.zsh ]] || source $CONFIG_DIR/.p10k.zsh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
