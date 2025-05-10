#!/bin/zsh
# (fzf) options for the interface

export _fzf_bat_opts="bat --paging=always --color=always -p --terminal-width \$FZF_PREVIEW_COLUMNS"
export _pager_opts="--paging=always"
export _fzf_large_up_preview_window='up,60%,border-bottom,+{2}+3/3,~3,nohidden'
export _fzf_editor_action="$EDITOR {1}\$([ -n {2} ] && echo :{2} )"



export FZF_DEFAULT_OPTS="
	--delimiter='\t'
	--info=inline
	--preview-window=:hidden:cycle
	--cycle
	--ansi
	--preview 'lessfilter {}'

	--height='100%' # default
	--min-height=$DISPLAY_LINES
	--prompt='' --pointer='' --marker='-'
	--reverse
	--no-scrollbar
	--no-separator
	--border=sharp
	--margin=0
	--padding 1,2
	--header ''
	
	--bind '?:toggle-preview'
	--bind 'alt-\:toggle-wrap'
	--bind 'ctrl-\:toggle-preview-wrap'
	--bind 'ctrl-a:select-all'
	--bind 'alt-a:toggle-all'
	--bind 'ctrl-y:execute-silent(echo {+} | ${CLIPcmd})'
	--bind 'alt-y:execute-silent(echo {+} | ${CLIPcmd})'
	--bind 'alt-space:toggle+down'
	--bind 'ctrl-o:execute($_fzf_editor_action)'
	--bind 'ctrl-l:execute($PAGER $_pager_opts {+1})'
	--bind 'alt-e:execute-silent(code -n -g {1}:{2})'
	--bind 'alt-o:execute-silent(o {+1})'
	--bind 'alt-d:execute-silent({while IFS= read -r line; do o \"\$(dirname \$line)\"; done} <<< {+})'
	--bind 'alt-u:unbind(one)'
	--bind 'ctrl-u:cancel'
	--bind 'alt-enter:print-query'
	--bind 'alt-p:become(echo {})'
	--bind 'alt-P:become(echo {+})'
	--bind 'alt-h:preview:($_fzf_bat_opts -l toml --wrap=character $Zdir/ancillary/fzf-help.ini)'
	--bind 'alt-j:transform:echo \"pos(\$(( \$RANDOM % \$FZF_TOTAL_COUNT )))\"'
	--bind 'alt-/:jump'
	--bind 'f1:pos(1)'
	--bind 'f2:pos(2)+accept'
	--bind 'f3:pos(3)+accept'
	--bind 'f4:pos(4)+accept'
	--bind 'f5:pos(5)+accept'
	--bind 'f6:pos(6)+accept'
	--bind 'f7:pos(7)+accept'
	--bind 'f8:pos(8)+accept'
	--bind 'f9:pos(9)+accept'
	--bind 'f10:pos(10)+accept'
	--bind 'f11:pos(11)+accept'
	--bind 'f12:pos(12)+accept'
	--bind 'ctrl-r:become($FZL__CMD)'
"
setopt NO_NOMATCH