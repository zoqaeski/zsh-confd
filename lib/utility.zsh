#
# Defines general aliases and functions.
#
# Authors:
#   Robby Russell <robby@planetargon.com>
#   Suraj N. Kurapati <sunaku@gmail.com>
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#   Robbie Smith <zoqaeski@gmail.com>
#

# Correct commands.
setopt CORRECT

#
# Aliases
#

# Disable correction.
alias ack='nocorrect ack'
alias cd='nocorrect cd'
alias cp='nocorrect cp'
alias ebuild='nocorrect ebuild'
alias gcc='nocorrect gcc'
alias gist='nocorrect gist'
alias grep='nocorrect grep'
alias heroku='nocorrect heroku'
alias ln='nocorrect ln'
alias man='nocorrect man'
alias mkdir='nocorrect mkdir'
alias mv='nocorrect mv'
alias mysql='nocorrect mysql'
alias rm='nocorrect rm'

# Disable globbing disabled
#alias fc='noglob fc'
#alias find='noglob find'
#alias ftp='noglob ftp'
#alias history='noglob history'
#alias locate='noglob locate'
#alias rake='noglob rake'
#alias rsync='noglob rsync'
#alias scp='noglob scp'
#alias sftp='noglob sftp'

# Define general aliases.
alias _='sudo'
alias b='${(z)BROWSER}'
#alias cp="${aliases[cp]:-cp} -i"
alias e='${(z)EDITOR}'
#alias ln="${aliases[ln]:-ln} -i"
alias mkdir="${aliases[mkdir]:-mkdir} -p"
#alias mv="${aliases[mv]:-mv} -i"
alias p='${(z)PAGER}'
alias po='popd'
alias pu='pushd'
#alias rm="${aliases[rm]:-rm} -i"
alias type='type -a'

# ls
if is-callable 'dircolors'; then
  # GNU Core Utilities
  alias ls='ls --group-directories-first'

  if zstyle -t ':omz:utility:ls' color; then
    if [[ -s "$HOME/.dir_colors" ]]; then
      eval "$(dircolors "$HOME/.dir_colors")"
    else
      eval "$(dircolors)"
    fi
    alias ls="$aliases[ls] --color=auto"
  else
    alias ls="$aliases[ls] -F"
  fi
else
  # BSD Core Utilities
  if zstyle -t ':omz:utility:ls' color; then
    export LSCOLORS="exfxcxdxbxegedabagacad"
    alias ls="ls -G"
  else
    alias ls='ls -F'
  fi
fi

alias l='ls -1A'         # Lists in one column, hidden files.
alias ll='ls -lh'        # Lists human readable sizes.
alias lr='ll -R'         # Lists human readable sizes, recursively.
alias la='ll -A'         # Lists human readable sizes, hidden files.
alias lm='la | "$PAGER"' # Lists human readable sizes, hidden files through pager.
alias lx='ll -XB'        # Lists sorted by extension (GNU only).
alias lk='ll -Sr'        # Lists sorted by size, largest last.
alias lt='ll -tr'        # Lists sorted by date, most recent last.
alias lc='lt -c'         # Lists sorted by date, most recent last, shows change time.
alias lu='lt -u'         # Lists sorted by date, most recent last, shows access time.
alias sl='ls'            # I often screw this up.

# Mac OS X Everywhere
if [[ "$OSTYPE" == darwin* ]]; then
  alias o='open'
  alias get='curl --continue-at - --location --progress-bar --remote-name --remote-time'
else
  alias o='xdg-open'
  alias get='wget --continue --progress=bar --timestamping'

  if (( $+commands[xclip] )); then
    alias pbcopy='xclip -selection clipboard -in'
    alias pbpaste='xclip -selection clipboard -out'
  fi

  if (( $+commands[xsel] )); then
    alias pbcopy='xsel --clipboard --input'
    alias pbpaste='xsel --clipboard --output'
  fi
fi

alias pbc='pbcopy'
alias pbp='pbpaste'

# Resource Usage
alias df='df -kh'
alias du='du -kh'

if (( $+commands[htop] )); then
  alias top=htop
else
  alias topc='top -o cpu'
  alias topm='top -o vsize'
fi

# Miscellaneous

# Serves a directory via HTTP.
alias http-serve='python -m SimpleHTTPServer'

# Colourise Pacman - disabled until I reinstall everything.
alias pacman='pacman-color'

# Backlight
alias backlight='sudo /usr/local/sbin/backlight'

# My aliases
alias play='plait'

# Udisks shorthands
alias bmount='bashmount'
alias dmount='udisksctl mount'
alias dumount='udisksctl unmount'

#
# Functions
#

# Makes a directory and changes to it.
function mkdcd {
  [[ -n "$1" ]] && mkdir -p "$1" && builtin cd "$1"
}

# Changes to a directory and lists its contents.
function cdls {
  builtin cd "$argv[-1]" && ls "${(@)argv[1,-2]}"
}

# Pushes an entry onto the directory stack and lists its contents.
function pushdls {
  builtin pushd "$argv[-1]" && ls "${(@)argv[1,-2]}"
}

# Pops an entry off the directory stack and lists its contents.
function popdls {
  builtin popd "$argv[-1]" && ls "${(@)argv[1,-2]}"
}

# Prints columns 1 2 3 ... n.
function slit {
  awk "{ print ${(j:,:):-\$${^@}} }"
}

# Finds files and executes a command on them.
function find-exec {
  find . -type f -iname "*${1:-}*" -exec "${2:-file}" '{}' \;
}

# Displays user owned processes status.
function psu {
  ps -{U,u}" ${1:-$USER}" -o 'pid,%cpu,%mem,command' "${(@)argv[2,-1]}"
}

# Disables correction for sudo, and passes aliases
alias sudo='noglob do_sudo '
function do_sudo
{
    integer glob=1
    local -a run
    run=( command sudo )
    if [[ $# -gt 1 && $1 = -u ]]; then
        run+=($1 $2)
        shift ; shift
    fi
    (($# == 0)) && 1=/bin/zsh
    while (($#)); do
        case "$1" in
        command|exec|-) shift; break ;;
        nocorrect) shift ;;
        noglob) glob=0; shift ;;
        *) break ;;
        esac
    done
    if ((glob)); then
        PATH="/sbin:/usr/sbin:/usr/local/sbin:$PATH" $run $~==*
    else
        PATH="/sbin:/usr/sbin:/usr/local/sbin:$PATH" $run $==*
    fi
}