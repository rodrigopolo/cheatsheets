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


### Homebrew packages
```sh
brew install \
jq fzf bat btm bmon btop gpac ncdu \
node tmux tree wget nano zinit aria2 \
p7zip bottom fdupes ffmpeg figlet \
gdrive cmatrix prettier exiftool nushell \
goaccess fastfetch unimatrix media-info \
imagemagick mssql-tools18 astrometry-net
```

Check `my.zshrc` in the repo

### Set the prompt
```sh
touch ~/.hushlogin
p10k configure
```

Set VCS colors with `nano .p10k.zsh`
```sh
    local      clean='%F{#fbf1c7}' # black foreground  %0F Git branch
    local   modified='%F{#fbf1c7}' # black foreground  %0F !1
    local       meta='%F{#ff0000}' # white foreground  %7F
    local  untracked='%F{#fbf1c7}' # black foreground  %0F
    local conflicted='%F{#af3029}' # red foreground    %1F
```

Check settings
```sh
typeset -m 'POWERLEVEL9K_*'
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

### Nano Color
```sh
echo -e "include "/opt/homebrew/share/nano/*.nanorc"\n" > ~/.nanorc
```

### unimatrix
```sh
sudo curl -L https://raw.githubusercontent.com/will8211/unimatrix/master/unimatrix.py -o /usr/local/bin/unimatrix
sudo chmod a+rx /usr/local/bin/unimatrix
unimatrix -s 90
```

## Shell settings in `.zshrc`
```sh
export PATH=~/.bin:/usr/local/sbin:/opt/homebrew/bin:/Applications/MKVToolNix-90.0.app/Contents/MacOS:/Applications/Hugin/PTBatcherGUI.app/Contents/MacOS:$PATH

# Enable color support
autoload -U colors && colors
export TERM=xterm-256color

# Alias for color and weather
alias ls='ls -G'
alias tree='tree -C'
alias grep='grep --color=auto'
alias weather='curl wttr.in'

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

# Editor
export HOMEBREW_EDITOR=/usr/bin/nano

# https://starship.rs/
if [[ $TERM_PROGRAM == "Apple_Terminal" ]]; then
    PROMPT='%B%F{green}%n@%m%b %F{yellow}%~ %f$ '
else
    eval "$(starship init zsh)"
fi

# Show FastFetch at start
fastfetch

```

### Ghostty settings `~/Library/Application\ Support/com.mitchellh.ghostty/config`
```
# Custom settings

# ghostty +list-themes
theme = flexoki-dark

background-opacity = 0.80
background-blur-radius = 10
cursor-style = block
window-height = 34
window-width = 125

#window-decoration = false
#background = 000000

clipboard-trim-trailing-spaces = true

# No ligatures
font-feature = -calt
font-feature = -dlig
font-feature = -liga
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

### Misc
```
https://github.com/const-void/DOOM-fire-zig
Ctrl+R for search
```