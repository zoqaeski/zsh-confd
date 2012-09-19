#
# Initialises oh-my-zsh
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#	Robbyrussell <https://github.com/robbyrussell/oh-my-zsh>
#   Robbie Smith <zoqaeski@gmail.com>
#

#
# Initialisation
#

# Check for the minimum supported version.
min_zsh_version='4.3.10'
if ! autoload -Uz is-at-least || ! is-at-least "$min_zsh_version"; then
  print "omz: old shell detected, minimum required: $min_zsh_version" >&2
  return 1
fi
unset min_zsh_version

# Disable color and theme in dumb terminals.
if [[ "$TERM" == 'dumb' ]]; then
  zstyle ':omz:*:*' color 'no'
  zstyle ':omz:prompt' theme 'off'
fi

# Load Zsh modules.
zstyle -a ':omz:load' zmodule 'zmodules'
for zmodule ("$zmodules[@]") zmodload "zsh/${(z)zmodule}"
unset zmodule{s,}

# Autoload Zsh functions.
zstyle -a ':omz:load' zfunction 'zfunctions'
for zfunction ("$zfunctions[@]") autoload -Uz "$zfunction"
unset zfunction{s,}

# Source files (the order matters).
source "${0:h}/helper.zsh"

# add a function path
fpath=($ZSH_CONFD/functions $ZSH_CONFD/completions $fpath)

# Load all of the config files in $ZSH_CONFD that end in .zsh
# TIP: Add files you don't want in git to .gitignore
for config_file ($ZSH_CONFD/lib/*.zsh) ; do
	source $config_file
done

# Set ZSH_CUSTOM to the path where your custom config files
# and plugins exists, or else we will use the default custom/
if [[ -z "$ZSH_CUSTOM" ]]; then
    ZSH_CUSTOM="$ZSH_CONFD/custom"
fi

# Add all defined plugins to fpath. This must be done
# before running compinit.
for plugin ($plugins); do
  if is_plugin $ZSH_CUSTOM $plugin; then
    fpath=($ZSH_CUSTOM/plugins/$plugin $fpath)
  elif is_plugin $ZSH $plugin; then
    fpath=($ZSH_CONFD/plugins/$plugin $fpath)
  fi
done

# Load and run compinit
autoload -U compinit
compinit -i

# Load all of the plugins that were defined in ~/.zshrc
for plugin ($plugins); do
  if [ -f $ZSH_CUSTOM/plugins/$plugin/$plugin.plugin.zsh ]; then
    source $ZSH_CUSTOM/plugins/$plugin/$plugin.plugin.zsh
  elif [ -f $ZSH_CONFD/plugins/$plugin/$plugin.plugin.zsh ]; then
    source $ZSH_CONFD/plugins/$plugin/$plugin.plugin.zsh
  fi
done

# Load all of your custom configurations from custom/
for config_file ($ZSH_CUSTOM/*.zsh(N)) source $config_file

# Load the theme
zstyle -a ':omz:prompt' theme 'ztheme'
if (( $#ztheme > 0 )); then
	source "$ZSH_CONFD/themes/$ztheme[@].zsh"
  #prompt "$prompt_argv[@]"
else
  prompt 'off'
fi
unset ztheme

# vim: ft=zsh sw=2 ts=2 et
