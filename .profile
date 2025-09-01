#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias vim='nvim'

export FZF_DEFAULT_COMMAND="rg --files --hidden -g '!.git' -g '!node_modules' -g '!package-lock.json' --dfa-size-limit 1G"
# export FZF_DEFAULT_COMMAND='fd --type f'

export GOPATH=$HOME/gocode
export PATH=$PATH:$GOPATH/bin
export PATH=/opt/local/bin:/opt/local/sbin:$PATH

function f() {
    ya tool cs "$@"
}

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
  export PATH="$PATH:$(yarn global bin)"

	# pnpm
	export PNPM_HOME="/home/levabala/.local/share/pnpm"
	export PATH="$PNPM_HOME:$PATH"
	# pnpm end

  alias brightnessctl='sudo brightnessctl'

  setbrightness() {
    CURRENT_DISPLAY=$(xrandr --current | grep " connected" | awk '{print $1}')
    xrandr --output $CURRENT_DISPLAY --brightness $1

    echo "set brightness $1 for display $CURRENT_DISPLAY"
  }
fi

PROFILE_PRIVATE=~/.profile_private
if [ -f "$PROFILE_PRIVATE" ]; then 
  source $PROFILE_PRIVATE
fi

CARGO_ENV=$HOME/.cargo/env
if [ -f "$CARGO_ENV" ]; then
  echo lol
    . "$CARGO_ENV"
fi

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

export REACT_EDITOR=nvim

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
. "/Users/levabala/.deno/env"