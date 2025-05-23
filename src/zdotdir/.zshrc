#!/bin/zsh

# default env values

ZDOTDIR=$__ZDOTDIR
unset HISTFILE

eval "$(awk '
  BEGIN {process = 1}
  /^;/ {
    process = 0
  }
  process {
	  	sub(/=/, ":="); 
	  	print ": ${" $0 "}"; 
	  	next
  }
  !process {print $0}
' $FZL_SCRATCH_ENV)"

[[ -f $FZL_SCRATCH_ZPROFILE ]] && source $FZL_SCRATCH_ZPROFILE
[[ -f $FZL_SCRATCH_ZSHRC ]] && source $FZL_SCRATCH_ZSHRC || {
	source $FZL_SCRATCH_START
}
source $FZL_SCRATCH_OPTS

# special setup
if [[ $FZL_EMPTY_CLOSE == true ]]; then
	fzl-accept-line-widget() {
		if [[ -z $BUFFER ]]; then
			exit 0
		fi
		zle accept-line
	}
	zle -N fzl-accept-line-widget
	bindkey ${FZL_ACCEPT_LINE_KEY:-'^M'} fzl-accept-line-widget # directly overwriting accept-line runs into recursion problems
fi


# keybinds
if [[ $FZL_ESC_CLOSE == true ]]; then
		zle -N fzl-exit-widget
		fzl-exit-widget() {
			exit
		}

		bindkey -v
		bindkey '^[' fzl-exit-widget
fi

# /dev/tty unhandled
if [[ -n $FZL_RELOAD_KEY ]]; then
	zle -N fzl-reload-widget
	fzl-reload-widget() {
		exec fzl -
	}
	bindkey $FZL_RELOAD_KEY fzl-reload-widget
fi

FZL_COMMAND_COUNTER=0

if [[ -n $FZL_MAX_COMMANDS ]]; then
	((FZL_MAX_COMMANDS -= 1))
fi


autoload -Uz add-zsh-hook
__fzl_precmd() {
	if [[ -n $FZL_MAX_COMMANDS ]]; then
		if ((FZL_COMMAND_COUNTER > (FZL_MAX_COMMANDS / 2))); then
			((FZL_MAX_COMMANDS % 2)) && read
			exit 0
		fi
	fi
	if [[ -n $FZL_CMD ]]; then
		setopt NO_NOTIFY NO_MONITOR
		if ! ((FZL_COMMAND_COUNTER)) && ; then
			{
				sleep $FZL_SEND_KEY_DELAY
				case "$OSTYPE" in
				linux*)
					printf $FZL_CMD | xdotool type --delay 0 --file - >/dev/null
					;;
				darwin*)
					osascript -e "tell application \"System Events\" to keystroke \"$FZL_CMD\"" >/dev/null
					;;
				*) ;;
				esac
			} &
		fi
	fi
	((FZL_COMMAND_COUNTER += 1))
}
add-zsh-hook precmd __fzl_precmd