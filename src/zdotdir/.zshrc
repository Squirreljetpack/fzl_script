#!/bin/zsh

# default env values

ZDOTDIR=$__ZDOTDIR
eval $(awk '
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
' $FZL_SCRATCH_ENV)

[[ -f $FZL_SCRATCH_ZPROFILE ]] && source $FZL_SCRATCH_ZPROFILE
[[ -f $FZL_SCRATCH_ZSHRC ]] && source $FZL_SCRATCH_ZSHRC || {
	source $FZL_SCRATCH_START
}

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
if [[ -n $FZL_RELOAD_KEY ]]; then
	zle -N fzl-reload-widget
	fzl-reload-widget() {
		exec $FZL_CMD
	}
	bindkey $FZL_RELOAD_KEY fzl-reload-widget
fi
if (($FZL_MAX_COMMANDS)); then
	((FZL_MAX_COMMANDS -= 1))
	autoload -Uz add-zsh-hook
	command_counter=0
	__fzl_mc_precmd() {
		if ((command_counter > (FZL_MAX_COMMANDS / 2))); then
			((FZL_MAX_COMMANDS % 2)) && read
			exit 0
		fi
		((command_counter += 1))
	}
	add-zsh-hook precmd __fzl_mc_precmd
fi
if [[ -n $FZL_FZS_CMD ]]; then
	setopt LOCAL_OPTIONS NO_NOTIFY NO_MONITOR
	{
		sleep $FZL_SEND_KEY_DELAY
		case "$OSTYPE" in
		linux*)
			printf $FZL_FZS_CMD | xdotool type --delay 0 --file - >/dev/null
			;;
		darwin*)
			osascript -e "tell application \"System Events\" to keystroke \"$FZL_FZS_CMD\"" >/dev/null
			;;
		*) ;;
		esac
	} &
fi
