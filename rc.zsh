# ~/.zshrc
# (this is actually symlinked from $ZSH_CONFD/rc.zsh

# Set the path to my zsh configurations
# (Not sure if I need this, as it's also set in ~/.zshenv
export ZSH_CONFD=$HOME/.config/zsh

# Set the key mapping style to 'emacs' or 'vi'.
zstyle ':omz:editor' keymap 'emacs'

# Auto convert .... to ../..
zstyle ':omz:editor' dot-expansion 'yes'

# Set case-sensitivity for completion, history lookup, etc.
zstyle ':omz:*:*' case-sensitive 'no'

# Color output (auto set to 'no' on dumb terminals).
zstyle ':omz:*:*' color 'yes'

# Auto set the tab and window titles.
zstyle ':omz:terminal' auto-title 'yes'
# oh-my-zsh variable. TODO: replace it with zstyle
#DISABLE_AUTO_TITLE == "false" 

# Set the Zsh modules to load (man zshmodules).
zstyle ':omz:load' zmodule 'attr' 'stat'

# Set the Zsh functions to load (man zshcontrib).
zstyle ':omz:load' zfunction 'zargs' 'zmv'

# Set name of the theme to load.
# Look in $ZSH_CONFD/themes/
zstyle ':omz:prompt' theme 'zoqaeski'

# Which plugins would you like to load? (plugins can be found in $ZSH_CONFD/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=()

source $ZSH_CONFD/init.zsh

# Customize to your needs...

# Enable UIM
#uim-fep


# vim: ft=zsh sw=2 ts=2 et
