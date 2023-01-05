#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias vim='nvim'

# fzf ignore node_modules and .git
export FZF_DEFAULT_COMMAND='rg --files --hidden -g "!{node_modules/*,.git/*,dist/*,.build/*,.build_cache/*}" -g "!**/*.{gz,lock,png,yml}" --dfa-size-limit 1G'

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

source ~/.profile_private
