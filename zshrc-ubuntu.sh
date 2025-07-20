export PATH=$PATH:/home/rpolo/.local/bin

# For consistent behavior across terminals
export TERM=xterm-256color
export LSCOLORS="GxFxCxDxBxegedabagCxgx"

# Fastfetch, you can disable it
fastfetch -c examples/7.jsonc

# If you're using macOS, you'll want this enabled
# if [[ -f "/opt/homebrew/bin/brew" ]] then
#   eval "$(/opt/homebrew/bin/brew shellenv)"
# fi

# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Add in ice
if [[ "$TERM_PROGRAM" != "Apple_Terminal" ]]; then
   zinit ice depth=1;

   # Add in snippets
   zinit snippet OMZL::git.zsh
   zinit snippet OMZP::git
   zinit snippet OMZP::sudo
   zinit snippet OMZP::archlinux
   zinit snippet OMZP::aws
   zinit snippet OMZP::kubectl
   zinit snippet OMZP::kubectx
   zinit snippet OMZP::command-not-found
fi

# Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Load completions
autoload -Uz compinit && compinit

zinit cdreplay -q

# Load oh-my-posh only in other terminals
if [[ "$TERM_PROGRAM" != "Apple_Terminal" ]]; then
  eval "$(oh-my-posh init zsh --config ~/.cache/oh-my-posh/themes/rodrigopolo.omp.json)"
fi

# Keybindings
bindkey -e
bindkey '^[[A' history-search-backward # up
bindkey '^[[B' history-search-forward # down
bindkey '^[w' kill-region

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# Man pages color settings
export LESS_TERMCAP_mb=$'\e[1;34m'
export LESS_TERMCAP_md=$'\e[1;33m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[1;44;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;32m'

# Aliases
alias ls='ls -G --color=auto'
alias grep='grep --color=auto'
alias tree='tree -C'
alias vim='nvim'

# Shell integrations
eval "$(/home/rpolo/.fzf/bin/fzf --zsh)"
#eval "$(zoxide init zsh)"
eval "$(zoxide init --cmd j zsh)"


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh