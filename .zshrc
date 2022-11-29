fpath+=~/.zfunc

[[ -e ~/.profile ]] && emulate sh -c 'source ~/.profile'

# enable vim mode
bindkey -v

# shortcut for reverse-search
bindkey '^R' history-incremental-search-backward

# Set PATH, MANPATH, etc., for Homebrew.
eval "$(/opt/homebrew/bin/brew shellenv)"

alias ya='/Users/levabala/arcadia/ya'

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
export NVM_DIR="${nvm_path}"

[ -s "${brew_opt_path}/nvm/nvm.sh" ] && . "${brew_opt_path}/nvm/nvm.sh"  # This loads nvm
# TODO: use zsh-compatible completion 
# [ -s "${brew_opt_path}/nvm/etc/bash_completion.d/nvm" ] && . "${brew_opt_path}/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

alias arm="arch -arm64 zsh"
alias intel="arch -x86_64 zsh"
