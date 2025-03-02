# Enable color support
autoload -U colors && colors
export TERM=xterm-256color

fastfetch

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Editor
export HOMEBREW_EDITOR=/usr/bin/nano

# Golang environment variables
export GOROOT=/usr/local/go
export GOPATH=$HOME/go

# Paths
export PATH=~/.bin:/usr/local/sbin:/opt/homebrew/bin:/Applications/MKVToolNix-90.0.app/Contents/MacOS:/Applications/Hugin/PTBatcherGUI.app/Contents/MacOS:$GOPATH/bin:$GOROOT/bin:$HOME/.local/bin:/opt/homebrew/anaconda3/bin:$PATH

# Source/Load zinit
source /opt/homebrew/opt/zinit/zinit.zsh

# Add in Powerlevel0k in non-Apple Terminals
if [[ $TERM_PROGRAM == "Apple_Terminal" ]]; then
    PROMPT='%B%F{green}%n@%m%b %F{yellow}%~ %f$ '
else
    zinit ice depth=1; zinit light romkatv/powerlevel10k
fi

# Asynchronous Plugin Loading
zinit light-mode for \
  zsh-users/zsh-syntax-highlighting \
  zsh-users/zsh-completions \
  zsh-users/zsh-autosuggestions \
  Aloxaf/fzf-tab

# Add in snippets
zinit snippet OMZP::git

# Load completions
autoload -Uz compinit && compinit -C

if [[ $TERM_PROGRAM != "Apple_Terminal" ]]; then
    # To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
    [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

    # Icon
    POWERLEVEL9K_OS_ICON_BACKGROUND='#d65c0f'
    POWERLEVEL9K_OS_ICON_FOREGROUND='#fbf1c7'

    # Dir
    POWERLEVEL9K_DIR_ANCHOR_BOLD=false 
    POWERLEVEL9K_DIR_BACKGROUND='#d79920'
    POWERLEVEL9K_DIR_FOREGROUND='#f8eec4'
    # POWERLEVEL9K_DIR_ANCHOR_FOREGROUND='#0000ff' # ~

    # VCS
    # If POWERLEVEL9K_VCS_CONTENT_EXPANSION goes to my_git_formatter
    # local      clean='%F{#fbf1c7}' # black foreground - Git branch
    # local   modified='%F{#fbf1c7}' # black foreground - !1
    # local       meta='%F{#ff0000}' # white foreground
    # local  untracked='%F{#fbf1c7}' # black foreground
    # local conflicted='%F{#af3029}' # red foreground

    # Only affects icon
    POWERLEVEL9K_VCS_VISUAL_IDENTIFIER_COLOR='#fbf1c7'

    POWERLEVEL9K_VCS_CLEAN_BACKGROUND='#689d6a' # git clean background
    POWERLEVEL9K_VCS_MODIFIED_BACKGROUND='#ad8302' # git modified background
    POWERLEVEL9K_VCS_UNTRACKED_BACKGROUND='#af3029' # git untracked background

    POWERLEVEL9K_STATUS_ERROR=true
    POWERLEVEL9K_STATUS_ERROR_BACKGROUND='#000000'
    POWERLEVEL9K_STATUS_ERROR_FOREGROUND='#af3029'

    POWERLEVEL9K_STATUS_OK=true
    POWERLEVEL9K_STATUS_OK_BACKGROUND='#000000'
    POWERLEVEL9K_STATUS_OK_FOREGROUND='#add14c'

    POWERLEVEL9K_COMMAND_EXECUTION_TIME_THRESHOLD=1
    POWERLEVEL9K_COMMAND_EXECUTION_TIME_VISUAL_IDENTIFIER_EXPANSION=''
    POWERLEVEL9K_COMMAND_EXECUTION_TIME_BACKGROUND='#2e2a29'
    POWERLEVEL9K_COMMAND_EXECUTION_TIME_FOREGROUND='#c4ba92'
    POWERLEVEL9K_COMMAND_EXECUTION_TIME_PRECISION=1

    POWERLEVEL9K_TIME_FORMAT='%D{%I:%M%p}'
    POWERLEVEL9K_TIME_BACKGROUND='#3d3837'
    POWERLEVEL9K_TIME_FOREGROUND='#c4ba92'
    POWERLEVEL9K_TIME_VISUAL_IDENTIFIER_EXPANSION=''

fi

# Keybindings
bindkey -e
bindkey '^[[1;5A' history-search-backward
bindkey '^[[1;5B' history-search-forward

# History settings
export HISTSIZE=10000
export HISTFILE="$HOME/.zsh_history"
export SAVEHIST=$HISTSIZE
export HISTDUP=erase
setopt INC_APPEND_HISTORY  # Add history immediately instead of waiting for session end
setopt EXTENDED_HISTORY  # Store timestamps in history
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

# Misc alias
alias weather='curl -s wttr.in'

# Enable color alias
alias ls='ls -G --color=auto'
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

# Shell integrations
eval "$(fzf --zsh)"
