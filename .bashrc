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

## history preserving
# avoid duplicates..
export HISTCONTROL=ignoredups:erasedups

# append history entries..
shopt -s histappend

# After each command, save and reload history
HISTORY_SAVE_RELOAD="history -a; history -c; history -r"
export PROMPT_COMMAND="${HISTORY_SAVE_RELOAD}; printf '\033]0;%s@%s:%s\007' '${USER}' '${HOSTNAME%%.*}' '${PWD/#$HOME/\~}'"

# fzf ignore node_modules and .git
export FZF_DEFAULT_COMMAND='rg --files --follow --no-ignore-vcs --hidden -g "!{node_modules/*,.git/*}"'

# pnpm
export PNPM_HOME="/home/levabala/.local/share/pnpm"
export PATH="$PNPM_HOME:$PATH"
# pnpm end