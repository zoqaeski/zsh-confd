#
# Defines helper functions.
#
# Authors:
#   Robbie Smith <zoqaeski@gmail.com>
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Checks a boolean variable for "true".
# Case insensitive: "1", "y", "yes", "t", "true", "o", and "on".
function is-true {
  [[ -n "$1" && "$1" == (1|[Yy]([Ee][Ss]|)|[Tt]([Rr][Uu][Ee]|)|[Oo]([Nn]|)) ]]
}

# Checks a name if it is a command, function, or alias.
function is-callable {
  (( $+commands[$1] )) || (( $+functions[$1] )) || (( $+aliases[$1] ))
}

# Prints the first non-empty string in the arguments array.
function coalesce {
  for arg in $argv; do
    print "$arg"
    return 0
  done
  return 1
}

# Checks if a file can be autoloaded by trying to load it in a subshell.
function autoloadable {
  ( unfunction $1 ; autoload -U +X $1 ) &> /dev/null
}

# Determines if a zsh file is a plugin
is_plugin() {
  local base_dir=$1
  local name=$2
  test -f $base_dir/plugins/$name/$name.plugin.zsh \
    || test -f $base_dir/plugins/$name/_$name
}

## Loads Oh My Zsh plugins
#function load_plugin {
#  local zplugin=$1
#  local ofunction_glob='^([_.]*|prompt_*_setup|README*)(.N:t)'
#
#  # Add functions to $fpath.
#  fpath=($ZSH_CONFD/plugins/$zplugin $fpath)
#
#  function {
#    local ofunction
#
#    # Extended globbing is needed for listing autoloadable function directories.
#    setopt LOCAL_OPTIONS EXTENDED_GLOB
#
#    # Load plugin function definitions
#    for ofunction in $ZSH_CONFD/plugins/$zplugin/functions/$~ofunction_glob; do
#      autoload -Uz "$ofunction"
#    done
#  }
#
#  if zstyle -t ":omz:plugin:$zplugin" loaded; then
#    continue
#  elif [[ ! is_plugin $ZSH_CONFD $zplugin ]]; then
#    print "$0: no such plugin: $zplugin" >&2
#    continue
#  else
#    if is_plugin $ZSH_CONFD $zplugin; then
#      source "$ZSH_CONFD/plugins/$zplugin/$zplugin.plugin.zsh"
#    fi
#
#    if (( $? == 0 )); then
#      zstyle ":omz:plugin:$zplugin" loaded 'yes'
#    else
#      # Remove the $fpath entry.
#      fpath[(r)$ZSH_CONFD/plugins/${zplugin}/functions]=()
#
#      function {
#        local ofunction
#
#        # Extended globbing is needed for listing autoloadable function
#        # directories.
#        setopt LOCAL_OPTIONS EXTENDED_GLOB
#
#        # Unload Oh My Zsh functions.
#        for ofunction in $ZSH_CONFD/plugins/$zplugin/functions/$~ofunction_glob; do
#          unfunction "$ofunction"
#        done
#      }
#
#      zstyle ":omz:plugin:$zplugin" loaded 'no'
#    fi
#  fi
#
#}
#
#
## Loads Oh My Zsh modules.
#function loadplugin {
#  local -a plugins
#  local plugin
#  local ofunction_glob='^([_.]*|prompt_*_setup|README*)(.N:t)'
#
#  # $argv is overridden in the anonymous function.
#  plugins=("$argv[@]")
#
#  # Add functions to $fpath.
#  fpath=(${plugins:+${ZSH_CONFD}/plugins/${^plugins}/functions(/FN)} $fpath)
#
#  function {
#    local ofunction
#
#    # Extended globbing is needed for listing autoloadable function directories.
#    setopt LOCAL_OPTIONS EXTENDED_GLOB
#
#    # Load Oh My Zsh functions.
#    for ofunction in $ZSH_CONFD/plugins/${^plugins}/functions/$~ofunction_glob; do
#      autoload -Uz "$ofunction"
#    done
#  }
#
#  # Load Oh My Zsh plugins.
#  for plugin in "$plugins[@]"; do
#    if zstyle -t ":omz:plugin:$oplugin" loaded; then
#      continue
#    elif [[ ! is_plugin $plugin ]]; then
#      print "$0: no such plugin: $plugin" >&2
#      continue
#    else
#      if is_plugin $ZSH_CUSTOM $plugin; then
#        source "$OMZ/plugins/$oplugin/init.zsh"
#      fi
#
#      if (( $? == 0 )); then
#        zstyle ":omz:plugin:$oplugin" loaded 'yes'
#      else
#        # Remove the $fpath entry.
#        fpath[(r)$OMZ/plugins/${oplugin}/functions]=()
#
#        function {
#          local ofunction
#
#          # Extended globbing is needed for listing autoloadable function
#          # directories.
#          setopt LOCAL_OPTIONS EXTENDED_GLOB
#
#          # Unload Oh My Zsh functions.
#          for ofunction in $OMZ/plugins/$oplugin/functions/$~ofunction_glob; do
#            unfunction "$ofunction"
#          done
#        }
#
#        zstyle ":omz:plugin:$oplugin" loaded 'no'
#      fi
#    fi
#  done
#}


# vim: ft=zsh sw=2 ts=2 et
