# 
# My preferred zsh theme.
#
# Authors:
#	Robbie Smith <zoqaeski@gmail.com>
#	Sorin Ionescu <sorin.ionescu@gmail.com>
#

function collapse_pwd {
	local len=30 pre="…"
	echo "%$len<$pre<%~%<<"
}


setopt LOCAL_OPTIONS
unsetopt XTRACE KSH_ARRAYS
prompt_opts=(cr percent subst)

# Load required functions.
autoload -Uz add-zsh-hook

zstyle ':omz:editor' completing '%B%F{red}…%f%b'
#zstyle ':omz:editor:keymap:primary' overwrite ' %F{red}♺%f'
#zstyle ':omz:editor:keymap' alternate ' %F{yellow}❮%f%B%F{red}❮%f%b%F{red}❮%f'

PROMPT="%B%(!.%F{red}.%F{blue})%n%f%b@%F{yellow}%m:%l%f%b:%F{green}$(collapse_pwd)%f%b
%(!.%F{red}#.%F{blue}$)%f%b "
SPROMPT='zsh: correct %F{red}%R%f to %F{green}%r%f [nyae]? '


# vim:ft=zsh: 
