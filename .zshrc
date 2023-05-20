[[ -e ~/.profile ]] && emulate sh -c 'source ~/.profile'

# enable vim mode
bindkey -v

# shortcut for reverse-search
bindkey '^R' history-incremental-search-backward

#set history size
export HISTSIZE=10000
#save history after logout
export SAVEHIST=10000
#history file
export HISTFILE=~/.zhistory
#append into history file
setopt INC_APPEND_HISTORY
#save only one command if 2 common are same and consistent
setopt HIST_IGNORE_DUPS
#add timestamp for each entry
setopt EXTENDED_HISTORY   

export ARCADIA_ROOT=$HOME/arcadia
export ARC_EDITOR=nvim
export CS_WSVN=on

export GEM_HOME="$HOME/.gems"

# Set PATH, MANPATH, etc., for Homebrew.
eval "$(/opt/homebrew/bin/brew shellenv)"

if [ "$(sysctl -n sysctl.proc_translated)" = "1" ]; then
    brew_path="/usr/local/homebrew/bin"
    brew_opt_path="/usr/local/opt"
    nvm_path="$HOME/.nvm-x86"
else
    brew_path="/opt/homebrew/bin"
    brew_opt_path="/opt/homebrew/opt"
    nvm_path="$HOME/.nvm"
fi

export PATH="${brew_path}:${PATH}"
export PATH="/Users/levabala/Library/Python/3.9/bin:${PATH}"
export NVM_DIR="${nvm_path}"

[ -s "${brew_opt_path}/nvm/nvm.sh" ] && . "${brew_opt_path}/nvm/nvm.sh"  # This loads nvm

function grepdiff() {
    (cd ~/arcadia && arc diff --name-only trunk | xargs rg $@)
}

alias arm="arch -arm64 zsh"
alias intel="arch -x86_64 zsh"

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.gems/bin"

fpath+=~/.zfunc
autoload -Uz compinit
compinit -C
