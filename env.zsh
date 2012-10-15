#
# Defines environment variables.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#   Robbie Smith <zoqaeski@gmail.com>
#

# Set the path to my zsh configurations
export ZSH_CONFD=$HOME/.config/zsh

# Paths
typeset -gU cdpath fpath mailpath manpath path
typeset -gUT INFOPATH infopath
#typeset -gUT PATH path

# Set the the list of directories that cd searches.
# cdpath=(
#   $cdpath
# )

# Set the list of directories that info searches for manuals.
infopath=(
  /usr/local/share/info
  /usr/share/info
  $infopath
)

# Set the list of directories that man searches for manuals.
manpath=(
  /usr/local/share/man
  /usr/share/man
  $manpath
)

for path_file in /etc/manpaths.d/*(.N); do
  manpath+=($(<$path_file))
done
unset path_file

# Set the list of directories that Zsh searches for programs.
path=(
  $HOME/bin
  /usr/local/{bin,sbin}
  /usr/{bin,sbin}
  /{bin,sbin}
  $path
)

for path_file in /etc/paths.d/*(.N); do
  path+=($(<$path_file))
done
unset path_file

PATH=$HOME/bin:$PATH; export PATH

# Language
if [[ -z "$LANG" ]]; then
  eval "$(locale)"
fi

#
# Editors
export EDITOR='/usr/bin/vim'
export VISUAL='/usr/bin/vim'
export PAGER='/usr/bin/less'

# Browser
export BROWSER='/usr/bin/luakit'

# Less
# Set the default Less options.
export LESS='-F -g -i -M -w'

# Set the Less input preprocessor.
if (( $+commands[lesspipe.sh] )); then
  export LESSOPEN='| /usr/bin/env lesspipe.sh %s 2>&-'
fi

