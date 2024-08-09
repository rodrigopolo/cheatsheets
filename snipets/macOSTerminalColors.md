## Setting colors in macOS

Change the prompt in `~/.zshrc`
```sh
# Set the prompt
PROMPT='%B%F{green}%n@%m%b %F{yellow}%~ %f$ '

# Enable color support
autoload -U colors && colors
export TERM=xterm-256color

# Enable color
alias ls='ls -G'
alias tree='tree -C'
alias grep='grep --color=auto'

# Man pages color settings
export LESS_TERMCAP_mb=$'\e[1;31m'
export LESS_TERMCAP_md=$'\e[1;31m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[1;44;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;32m'

# Git color settings
git config --global color.ui auto
git config --global color.branch auto
git config --global color.diff auto
git config --global color.status auto
```

Load the [`Rodrigo Polo.terminal`](Rodrigo%20Polo.terminal) file.

* [Color themes for default macOS Terminal.app](https://github.com/lysyi3m/macos-terminal-themes)  
* [Make Mac Terminal App Beautiful and Productive](https://medium.com/@jackklpan/make-mac-terminal-app-beautiful-and-productive-213f24c0ef4f)


