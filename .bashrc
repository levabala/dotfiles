#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias vim='nvim'
set -o vi
PS1='[\u@\h \W]\$ '

export PATH="$PATH:$(yarn global bin)"

# fzf ignore node_modules and .git
export FZF_DEFAULT_COMMAND='rg --files --follow --no-ignore-vcs --hidden -g "!{node_modules/*,.git/*,dist/*}"'

# pnpm
export PNPM_HOME="/home/levabala/.local/share/pnpm"
export PATH="$PNPM_HOME:$PATH"
# pnpm end

alias brightnessctl='sudo brightnessctl'
