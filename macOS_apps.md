# macOS Apps

## Apps

| Adobe                   | Design and Photo    | Multimedia and Streaming  |
|-------------------------|---------------------|---------------------------|
| Adobe Lightroom Classic | Topaz Gigapixel AI  | DaVinci Resolve           |
| Adobe After Effects     | Topaz DeNoise AI    | Insta360 Studio           |
| Adobe Animate 2024      | Adobe DNG Converter | Blender                   |
| Adobe Audition          | LRTimelapse 6       | IINA                      |
| Adobe Media Encoder     | Affinity Photo 2    | VLC                       |
| Adobe Premiere Pro      | Raw Convertor       | Infuse                    |
| Adobe Photoshop         | Spherical Viewer    | Aegisub                   |
|                         | Panorama Stitcher   | MKVToolNix                |
|                         | Hugin               | CASTER                    |
|                         |                     | OBS                       |
|                         |                     | Accentize Complete Bundle |
|                         |                     | FabFilter Total Bundle    |


| Utilities               | Dev                 | Devices               |
|-------------------------|---------------------|-----------------------|
| NTFS for Mac            | Sublime Text        | Logitech Presentation |
| KeePassXC               | FileZilla           | Logi Options+         |
| KeePassium              | Ghostty             | EOS Webcam Utility    |
| FreeFileSync            | Warp                | Rode Central          |
| Disk Inventory X        | DbGate Premium      |                       |
| Inviska Rename          | DBeaver             |                       |
| Inviska MKV Extract     | Docker              |                       |
| AnyDesk                 | Robo 3T             |                       |
| Google Earth Pro        | Sequel Ace          |                       |
| Windows App             | SQLPro Studio       |                       |
| Office                  |                     |                       |
| QuickRes                |                     |                       |
| Lasso                   |                     |                       |
| Rectangle               |                     |                       |
| RawDigger               |                     |                       |
| Remote Desktop          |                     |                       |

| Browsers                | Astro               |
|-------------------------|---------------------|
| Opera                   | Stellarium          |
| Google Chrome           | StarStaX            |
| FireFox                 | Siril               |
| Brave Browser           | ASTAP               |
|                         | ASIAIR              |
|                         | QuickFits           |

## macOS Terminal and Ghostty

Download and install [Ghostty](https://ghostty.org/download)

### Install Homebrew
```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
echo >> ~/.zprofile
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"
```

### Install nerd fonts
```sh
brew install --cask font-meslo-for-powerlevel10k font-jetbrains-mono-nerd-font
```

### Install `git`, `wget`, `fzf`, `zoxide` and `oh-my-posh`
```sh
brew install git wget fzf zoxide fastfetch
brew install jandedobbeleer/oh-my-posh/oh-my-posh
```

### Set your Ghostty custom color palette
```sh
cat > /Applications/Ghostty.app/Contents/Resources/ghostty/themes/Rodrigo\ Polo << 'EOF'
palette = 0=#1a1a1a
palette = 1=#ed1b21
palette = 2=#2dc55e
palette = 3=#ecba0f
palette = 4=#2a84d2
palette = 5=#a716e4
palette = 6=#168cda
palette = 7=#83868e
palette = 8=#575653
palette = 9=#de352e
palette = 10=#1dd361
palette = 11=#f3bd09
palette = 12=#1e97df
palette = 13=#bf25f1
palette = 14=#259fe6
palette = 15=#ffffff
background = #1e1e1e
foreground = #ffffff
cursor-color = #98989d
cursor-text = #ffffff
selection-background = #3f638b
selection-foreground = #ffffff
EOF
```

### Set ghostty settings, font and colors
```sh
cat >> ~/Library/Application\ Support/com.mitchellh.ghostty/config << 'EOF'

# Custom settings

# To list themes: ghostty +list-themes
theme = Rodrigo Polo

window-height = 26
window-width = 125
background-opacity = 0.80
background-blur-radius = 10
cursor-style = block
clipboard-trim-trailing-spaces = true
font-family = MesloLGS NF, JetBrainsMono Nerd Font

# No ligatures
font-feature = -calt
font-feature = -dlig
font-feature = -liga

# window-decoration = false
# background = 000000

EOF
```

> Reload configuration before continuing

#### Customize Oh My Posh
1. Create the `.config/ohmyposh` dir.
2. Download or create your template exporting current.
3. Edit `~/.zshrc` and set the config.

Create config dir, export, edit or download templates
```sh
mkdir -p ~/.config/ohmyposh
cd ~/.config/ohmyposh
wget https://raw.githubusercontent.com/rodrigopolo/cheatsheets/refs/heads/master/rodrigopolo.omp.json
```

Examples of custom configurations
```sh
oh-my-posh config export --output ./current.json # Exports as JSON
oh-my-posh config export --format toml --output ./current.toml # Exports as toml
wget https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/refs/heads/main/themes/powerlevel10k_rainbow.omp.json
wget https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/refs/heads/main/themes/slim.omp.json
wget https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/refs/heads/main/themes/quick-term.omp.json
```

Example of how to load OMP in `~/.zshrc`
```sh
eval "$(oh-my-posh init zsh --config ~/.config/ohmyposh/slim.omp.json)"
```

### Set all the plug-ins and settings of `~/.zshrc`, then reload the terminal window.
```sh
cat >> ~/.zshrc << 'EOF'
# For consistent behavior across terminals
export TERM=xterm-256color

# Fastfetch, you can disable it
fastfetch -c examples/7.jsonc

# If you're using macOS, you'll want this enabled
if [[ -f "/opt/homebrew/bin/brew" ]] then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

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
  eval "$(oh-my-posh init zsh --config ~/.config/ohmyposh/rodrigopolo.omp.json)"
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
alias ls='ls -G --color'
alias grep='grep --color=auto'
alias tree='tree -C'
alias vim='nvim'

# Shell integrations
eval "$(fzf --zsh)"
eval "$(zoxide init zsh)"

EOF
```

### Remove the `Last login` info
```sh
touch ~/.hushlogin
```

Sources:
* [Zsh config](https://youtu.be/ud7YxC33Z3w)
* [`.zshrc`](https://github.com/dreamsofautonomy/zensh)
* [zoxide](https://youtu.be/aghxkpyRVDY)
* [oh-my-posh GitHub](https://github.com/jandedobbeleer/oh-my-posh)
* [oh-my-posh Themes](https://ohmyposh.dev/docs/themes)
* [OMP `zen.toml`](https://github.com/dreamsofautonomy/zen-omp)

## Homebrew packages
```sh
brew install \
jq bat btm bmon btop gpac ncdu eza \
node tmux tree wget nano zinit aria2 \
p7zip bottom fdupes ffmpeg figlet yazi \
gdrive cmatrix prettier exiftool nushell \
goaccess unimatrix media-info \
imagemagick mssql-tools18 astrometry-net
```

### Set `ncdu`
```sh
mkdir $HOME/.config/ncdu/
nano $HOME/.config/ncdu/config
```

Enable color and extended mode in `$HOME/.config/ncdu/config`
```
# Color
--color=dark
# Always enable extended mode
-e
```

### Mongo
```sh
brew tap mongodb/brew
brew install mongodb-database-tools
brew install mongosh
```

### SSH
```sh
ssh-keygen -t ed25519 -C "user@mail.com"
```

### Conda
```sh
wget https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-MacOSX-arm64.sh
bash Miniforge3-MacOSX-arm64.sh
conda config --set auto_activate_base false
```

### GDrive

Install
```bash
brew install gdrive
```

Download
```bash
gdrive files download --recursive "file/folder-id"
```

* Project: https://github.com/glotlabs/gdrive  
* Credentials: https://github.com/glotlabs/gdrive/blob/main/docs/create_google_api_credentials.md  
* Tutorial: https://www.youtube.com/watch?v=HCjAK0QA_3w  
* Config: `~/.config/gdrive3`

### Composer
```sh
which php
cd && curl -sS https://getcomposer.org/installer | php
mv composer.phar ~/.bin/composer
```

### StarShip
```sh
brew install starship
mkdir -p ~/.config && touch ~/.config/starship.toml
```

### unimatrix
```sh
sudo curl -L https://raw.githubusercontent.com/will8211/unimatrix/master/unimatrix.py -o /usr/local/bin/unimatrix
sudo chmod a+rx /usr/local/bin/unimatrix
unimatrix -s 90
```

## Figlet
```sh
brew install figlet
figlet -I2
figlet -f poison "Rodrigo Polo" 
figlet -f doom "Rodrigo Polo" 
figlet -f epic "Rodrigo Polo" 
figlet -f gothic "Rodrigo Polo" 
figlet -f larry3d "Rodrigo Polo" 
figlet -f rectangles "Rodrigo Polo" 
figlet -f slant "Rodrigo Polo" 
figlet -f smslant "Rodrigo Polo"
```

### RAR
```sh
cd ~/.apps
wget https://www.win-rar.com/fileadmin/winrar-versions/rarmacos-arm-612.tar.gz
tar xzf rarmacos-arm-612.tar.gz
rm rarmacos-arm-612.tar.gz
ln -s ~/.apps/rar/rar ~/.bin/rar
ln -s ~/.apps/rar/unrar ~/.bin/unrar
```

### Bottom
[Styling Bottom](https://clementtsang.github.io/bottom/nightly/configuration/config-file/styling/)  
```sh
mkdir $HOME/.config/bottom/
nano $HOME/.config/bottom/bottom.toml
```

`bottom.toml`
```
[styles]
theme = "gruvbox"
```

### Nushell
```sh
brew install nushell
nu
```

```sh
open file.json | select primerNombre primerApellido fechaNacimiento | where fechaNacimiento =~ "^1980"
```

```sh
open file.json | select primerNombre primerApellido fechaNacimiento | where fechaNacimiento =~ "07-23$"
```

```sh
open file.json | select primerNombre primerApellido fechaNacimiento | where fechaNacimiento =~ "22$"
```

```sh
open file.json | where ln =~ "(?i)gabri"
```

```sh
open file.json | where ln =~ "(?i)gabri" | where ln =~ "(?i)jos"
```

### Sublime Text defaults

```json
{
  "draw_white_space": "all",
  "ignored_packages":
  [
    "Vintage",
  ],
  "wrap_width": 68,
  "open_files_in_new_window": false,
  "scroll_past_end": true,
  "show_encoding": true,
  "word_wrap": false,
  "index_files": true,
  "font_size": 12,
}
```

Packages
```
MarkdownPreview.sublime-package
Sort Lines (Numerically).sublime-package
Sync View Scroll.sublime-package
```

### Lightroom Export Presets
```
~/Library/Application\ Support/Adobe/Lightroom/Export\ Presets/User\ Presets
```

### Custom `~/.bin`

Symbolic links in ~/.apps/
```sh
ln -s /Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl ~/.bin/sublime
ln -s /Applications/MAMP/Library/bin/mysql ~/.bin/mysql
ln -s /Applications/MAMP/Library/bin/mysqldump ~/.bin/mysqldump
ln -s /Applications/MAMP/bin/php/php7.4.21/bin/php ~/.bin/php
```

### Extra resolutions with displayplacer
```sh
brew install displayplacer
displayplacer list
```

```
Persistent screen id: AD421EA7-496A-4F73-904F-05E88C3673F8
Contextual screen id: 4
Serial screen id: s16843009
Type: 29 inch external screen
Resolution: 2560x1080

mode 26: res:2560x1080 hz:60 color_depth:8 <-- current mode
mode 36: res:2560x1080 hz:60 color_depth:8 scaling:on

Persistent screen id: CD0BFDE7-928E-47C3-8C47-8C75B8A49ADE
Contextual screen id: 1
Serial screen id: s2264
Type: 24 inch external screen
Resolution: 1920x1080

mode 36: res:1920x1080 hz:60 color_depth:8 <-- current mode
mode 55: res:1920x1080 hz:60 color_depth:8 scaling:on
mode 40: res:1280x720 hz:60 color_depth:8 scaling:on
```

```
displayplacer "id:CD0BFDE7-928E-47C3-8C47-8C75B8A49ADE mode:55"
```

### Misc
```
https://github.com/const-void/DOOM-fire-zig
Ctrl+R for search
```