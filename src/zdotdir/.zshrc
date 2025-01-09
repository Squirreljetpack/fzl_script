#!/bin/zsh

# default env values

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
' $FZL_ENV_FILE)

ZDOTDIR=$__ZDOTDIR

[[ -n $FZL_SCRATCH_ZPROFILE ]] && source $FZL_SCRATCH_ZPROFILE
[[ -n $FZL_SCRATCH_ZSHRC ]] && source $FZL_SCRATCH_ZSHRC || {
	. ~/.local/share/fzs/fzs_plugins.zsh
	. ~/.local/share/fzs/fzs_init.zsh
}

# keybinds
if [[ $FZL_ESC_CLOSE == true ]]; then
	zle -N fzl-exit-widget
	fzl-exit-widget() {
		exit
	}

	bindkey -v
	bindkey '^[' fzl-exit-widget
fi
if [[ $FZL_RELOAD == true ]]; then
	zle -N fzl-reload-widget
	fzl-reload-widget() {
		exec $FZL_CMD
	}
	bindkey -v
	bindkey '^R' fzl-reload-widget
fi
if [[ -n $FZL_MAX_COMMANDS ]]; then
	((FZL_MAX_COMMANDS -= 1))
	autoload -Uz add-zsh-hook
	command_counter=0
	__fzl_precmd() {
		if ((command_counter > (FZL_MAX_COMMANDS / 2))); then
			((FZL_MAX_COMMANDS % 2)) && read # wait happens regardless
			exit 0
		fi
		((command_counter += 1))
	}
	add-zsh-hook precmd __fzl_precmd
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
