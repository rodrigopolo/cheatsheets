Create disk image from folder:

```bash
hdiutil create \
-fs HFS+ \
-srcfolder /path/to/folder \
-volname "Volume Name" \
"image_file.dmg"
```

Create bootable disk

```bash
sudo \
/Applications/Install\ macOS\ Sierra.app/Contents/Resources/createinstallmedia \
--volume /Volumes/VolumeName \
--applicationpath /Applications/Install\ macOS\ Sierra.app \
--nointeraction
```

Prevent external disks from sleeping
```sh
sudo pmset -a disksleep 0
```

Add paths to system:
```sh
nano ~/.zshrc 
```

```sh
export PATH=~/.bin:/usr/local/sbin:$PATH
export HOMEBREW_EDITOR=/usr/bin/nano
```

Generate and add key
```sh
ssh-keygen -t ed25519 -C "your_email@example.com"
# eval "$(ssh-agent -s)"
# ssh-add ~/.ssh/id_ed25519
```

Add key to a remote server, and set the permissions
```sh
ssh-copy-id user@host
```

Reset defaults Launchpad
```sh
defaults write com.apple.dock ResetLaunchPad -bool true; killall Dock
```

Remove [ugly blue capslock indicator](https://discussions.apple.com/thread/255191086?sortBy=best)
```sh
sudo defaults write /Library/Preferences/FeatureFlags/Domain/UIKit.plist redesigned_text_cursor -dict-add Enabled -bool NO
```

Set volume from terminal
```sh
sudo osascript -e "set Volume 10"
```

List available voices
```sh
say -v '?'
```

Speak
```sh
say -v Alex "I'm setting up all the remote connections"
```

## File metadata
```sh
# List metadata
xattr <file or folder>
xattr -l <file or folder>

# List files with metadata
ls -l@ <file or folder>

# Remove the metadata
xattr -d "com.apple.lastuseddate#PS" <file or folder>
```

## Enable color in the Terminal app

Install `nano`
```sh
brew install nano
```

Edit `~/.nanorc` and add:
```sh
include "/opt/homebrew/share/nano/*.nanorc" # M1 CPU
include "/usr/local/share/nano/*.nanorc" # For Intel CPU
```

Change the prompt in `~/.zshrc`
```sh
PROMPT='%F{cyan}%n@%m %F{yellow}%~ %f%F{green}$%f ' # With user
PROMPT='%F{yellow}%~ %f%F{green}$%f ' # Without user
```

Enable color support in other apps adding this to `~/.zshrc`
```sh
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

## Matrix
```sh
cmatrix
unimatrix -s 90
```
https://github.com/will8211/unimatrix

## Weather
Cols 125, rows 40
```sh
curl wttr.in
curl wttr.in/:help
curl wttr.in/Guatemala\?format=2
curl wttr.in/Guatemala\?format=3
```
https://github.com/chubin/wttr.in

## Hollywood
```sh
docker run --rm -it bcbcarl/hollywood
```

## Utils
```sh
brew install \
fastfetch \
ncdu \
btop \
starship \
tmux \
bat
```

Extra sources:
* https://starship.rs/guide/#🚀-installation  
* https://starship.rs/presets/pastel-powerline  
* https://starship.rs/presets/tokyo-night  
* https://starship.rs/presets/gruvbox-rainbow  
* https://docs.warp.dev/appearance/prompt#starship  
* https://www.youtube.com/watch?v=cPWEX2446B4  
* https://github.com/ChrisTitusTech/mybash  

## Warp theme `~/.warp/themes/rodrigopolo.yaml`
```yaml
---
background: '#222222' # Terminal background color
accent: '#268bd2' # Accent color for UI elements
foreground: '#839496' # The foreground color
details: darker # Whether the theme is lighter or darker
#cursor: '#d3a964' # The cursor color (optional; defaults to accent color if omitted)
terminal_colors: # Ansi escape colors
  bright:
    black: '#073642'
    blue: '#268bd2'
    cyan: '#2aa198'
    green: '#859900'
    magenta: '#d33682'
    red: '#dc322f'
    white: '#eee8d5'
    yellow: '#b58900'
  normal:
    black: '#333437'
    blue: '#1081d6'
    cyan: '#0f7ddb'
    green: '#1dd361'
    magenta: '#a911eb'
    red: '#de352e'
    white: '#ffffff'
    yellow: '#f3bd09'
name: Rodrigo Polo
```

## Disable starship on Apple Terminal
```sh
if [[ $TERM_PROGRAM == "Apple_Terminal" ]]; then
    PROMPT='%B%F{green}%n@%m%b %F{yellow}%~ %f$ '
else
    eval "$(starship init zsh)"
fi
```

WezTerm settings `~/.wezterm.lua`
```lua
local wezterm = require 'wezterm'

return {
  font = wezterm.font("FiraCode Nerd Font"),
  font_size = 12.0,
  harfbuzz_features = {"calt=0", "clig=0", "liga=0"},
  initial_cols = 125,
  initial_rows = 40,
  window_background_opacity = 0.8,
  macos_window_background_blur = 20,
  scrollback_lines = 10000,
  enable_tab_bar = true,
  hide_tab_bar_if_only_one_tab = true,
  use_fancy_tab_bar = false,
  window_padding = {
    left = 8,
    right = 8,
    top = 4,
    bottom = 3,
  },
}
```