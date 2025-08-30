# macOS Apps

## Contents
* [Apps](#apps)
* [macOS Terminal and Ghostty](#macos-terminal-and-ghostty)
* [Homebrew packages](#homebrew-packages)
  * [Bottom](#bottom)
  * [SSH](#ssh)
  * [GDrive](#gdrive)
  * [Composer](#composer)
  * [FFmpeg progress bar](#ffmpeg-progress-bar)
  * [Symbolic links in `~/.local/bin`](#symbolic-links-in-localbin)
  * [Extra resolutions with displayplacer](#extra-resolutions-with-displayplacer)
  * [MongoDB Tools](#mongodb-tools)
  * [Microsoft ODBC 18 on Apple Silicon](#microsoft-odbc-18-on-apple-silicon)
  * [Nushell](#nushell)
* [Personalizations](#personalizations)
  * [Sublime Text defaults](#sublime-text-defaults)
  * [Sublime Packages](#sublime-packages)
  * [Lightroom Export Presets](#lightroom-export-presets)
  * [Misc](#misc)

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

### Install Homebrew
```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
echo >> ~/.zprofile
hbp=$([ "$(uname -m)" = "arm64" ] && echo "/opt/homebrew" || echo "/usr/local")
echo "eval \"\$(${hbp}/bin/brew shellenv)\"" >> ~/.zprofile
eval "$(${hbp} shellenv)"
```

### Install Ghostty
```
brew install --cask ghostty
```

> **NOTE:** From now on, we will use Ghostty as the main terminal emulator.

### Install nerd font
```sh
brew install --cask font-jetbrains-mono-nerd-font
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
font-family = JetBrainsMono Nerd Font

# No ligatures
font-feature = -calt
font-feature = -dlig
font-feature = -liga

# window-decoration = false
# background = 000000

EOF
```

> **Note:** Reload configuration before continuing

#### Oh My Posh Themes

Themes folder
```sh
# Get the themes folder
echo $(brew --prefix oh-my-posh)/themes/
#> /opt/homebrew/opt/oh-my-posh/themes/

# List themes
ls $(brew --prefix oh-my-posh)/themes/
```

My personal favorite themes
```sh
# Mix
eval "$(oh-my-posh init zsh --config /opt/homebrew/opt/oh-my-posh/themes/kushal.omp.json)"
eval "$(oh-my-posh init zsh --config /opt/homebrew/opt/oh-my-posh/themes/clean-detailed.omp.json)"
eval "$(oh-my-posh init zsh --config /opt/homebrew/opt/oh-my-posh/themes/takuya.omp.json)"


# Colorful
eval "$(oh-my-posh init zsh --config /opt/homebrew/opt/oh-my-posh/themes/atomic.omp.json)"
eval "$(oh-my-posh init zsh --config /opt/homebrew/opt/oh-my-posh/themes/jandedobbeleer.omp.json)"

# Colorful and minimalist
eval "$(oh-my-posh init zsh --config /opt/homebrew/opt/oh-my-posh/themes/marcduiker.omp.json)"
eval "$(oh-my-posh init zsh --config /opt/homebrew/opt/oh-my-posh/themes/cert.omp.json)"

# Barebones
eval "$(oh-my-posh init zsh --config /opt/homebrew/opt/oh-my-posh/themes/uew.omp.json)"
eval "$(oh-my-posh init zsh --config /opt/homebrew/opt/oh-my-posh/themes/tokyo.omp.json)"
```

#### Customize Oh My Posh
1. Create the `.config/ohmyposh` dir.
2. Download or create your template exporting current.
3. Edit `~/.zshrc` and set the config.

Create config dir, export, edit or download templates
```sh
mkdir -p ~/.config/ohmyposh
cd ~/.config/ohmyposh
oh-my-posh config export --output ./current.json # Exports as JSON
oh-my-posh config export --format toml --output ./current.toml # Exports as toml
```

Example of how to load OMP in `~/.zshrc`
```sh
eval "$(oh-my-posh init zsh --config ~/.config/ohmyposh/current.json)"
```

My personal theme
```sh
mkdir -p ~/.config/ohmyposh
cd ~/.config/ohmyposh
wget https://raw.githubusercontent.com/rodrigopolo/cheatsheets/refs/heads/master/rodrigopolo.omp.json
```

Switch between themes to try them out
```sh
# Set an index, and an array of the themes
th_index=0
th_dir=$(brew --prefix oh-my-posh)/themes/
th_jsons=($(ls $th_dir | grep -i -E "\.json$"))

# Then load each theme one by one by running this line
eval "$(oh-my-posh init zsh --config ${th_dir}/${th_jsons[th_index]})" && echo ${th_jsons[th_index]} && ((th_index++))
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
alias ls='ls -G --color=auto'
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
* `nano`: Modern text editor with syntax highlighting and undo/redo (replaces macOS `nano`)
* `findutils`: GNU find, xargs, etc., with advanced search options (replaces BSD `find`)
* `coreutils`: GNU versions of ls, cat, sort, etc., with enhanced features (replaces BSD `coreutils`)
* `curl`: Updated HTTP client with modern protocol support (replaces macOS `curl`)
* `wget`: Robust file downloader with recursive capabilities
* `grep`: GNU grep with faster performance and Perl-compatible regex (replaces BSD `grep`)
* `gnu-sed`: GNU sed with extended regex support (replaces BSD `sed`)
* `gawk`: GNU awk with advanced scripting features (replaces BSD `awk`)
* `make`: GNU make with advanced build features (replaces BSD `make`)
* `tree`: Displays directory structure visually
* `btop`: Modern, colorful system monitor (replaces macOS `top`)
* `bottom`: Cross-platform system monitor with graphical UI
* `bmon`: Bandwidth monitor for network interfaces
* `ncdu`: Disk usage analyzer with interactive interface
* `zinit`: Fast, flexible Zsh plugin manager
* `eza`: Modern `ls` replacement with color and Git integration
* `tmux`: Terminal multiplexer for session management
* `yazi`: Fast terminal file manager with preview capabilities
* `nushell`: Modern shell with structured data support (alternative to zsh/bash)
* `ripgrep`: `rg`, faster than grep
* `fd`: Faster than find
* `lsd`: modern `ls` replacements with color and git integration
* `prettier`: Code formatter for multiple languages
* `bat`: Syntax-highlighting cat alternative (enhances `cat`)
* `jq`: JSON processor for parsing and manipulating data
* `aria2`: Fast, multi-protocol download utility
* `gpac`: Multimedia framework for MP4/MPEG processing
* `ffmpeg`: Versatile tool for video/audio conversion and streaming
* `exiftool`: Metadata editor for images and media files
* `media-info`: Displays detailed media file information
* `imagemagick`: Image manipulation and conversion tool
* `p7zip`: 7z archive tool for compression/decompression
* `fdupes`: Finds and manages duplicate files
* `gdrive`: Google Drive CLI client for file management
* `figlet`: Creates ASCII art from text
* `cmatrix`: Matrix-style terminal animation
* `node`: Node.js runtime for JavaScript development
* `goaccess`: Real-time web log analyzer
* `astrometry-net`: Plate-solving tool for astronomical images

```sh
brew install \
nano findutils coreutils curl wget \
grep gnu-sed gawk make tree \
btop bottom bmon ncdu \
zinit eza tmux yazi nushell \
ripgrep fd lsd \
prettier bat jq \
aria2 yt-dlp gpac ffmpeg \
exiftool media-info imagemagick \
p7zip rar fdupes gdrive \
node goaccess figlet cmatrix astrometry-net
```

Path configuration for `~/.zshrc`
```sh
hbp=$([ "$(uname -m)" = "arm64" ] && echo "/opt/homebrew" || echo "/usr/local")
typeset -U path  # Ensure path array has no duplicates
path=(
  $hbp/opt/coreutils/libexec/gnubin      # GNU coreutils (ls, cat, sort, etc.)
  $hbp/opt/gnu-sed/libexec/gnubin        # GNU sed
  $hbp/opt/grep/libexec/gnubin           # GNU grep
  $hbp/opt/gawk/libexec/gnubin           # GNU awk
  $hbp/opt/findutils/libexec/gnubin      # GNU findutils (find, xargs)
  $hbp/opt/make/libexec/gnubin           # GNU make
  $hbp/opt/curl/bin                      # Homebrew curl
  $hbp/bin                               # nano, bash, wget, tree, htop, jq, git, rg, fd, exa, lsd
  $path
)
```

### Enable nano colors
```sh
brew install nano
hbp=$([ "$(uname -m)" = "arm64" ] && echo "/opt/homebrew" || echo "/usr/local")
echo -e "include \"${hbp}/share/nano/*.nanorc\"\\n" > ~/.nanorc
```

### Set colors for `ncdu`
```sh
mkdir -p ~/.config/ncdu/
cat >> ~/.config/ncdu/config << 'EOF'
# Color
--color=dark
# Always enable extended mode
-e
EOF
```

### Bottom
[Styling Bottom](https://clementtsang.github.io/bottom/nightly/configuration/config-file/styling/)  
```sh
mkdir -p ~/.config/bottom/
cat >> ~/.config/bottom/bottom.toml << 'EOF'
[styles]
theme = "gruvbox"
EOF
```

### SSH
```sh
ssh-keygen -t ed25519 -C "user@mail.com"
ssh-copy-id -i ~/.ssh/id_rsa.pub user@server
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
mv composer.phar ~/.local/bin/composer
```

### FFmpeg progress bar
```sh
curl -L -o ~/.local/bin/fpb https://github.com/rodrigopolo/fpb/releases/download/v1.0.1/fpb-darwin-arm64
chmod +x ~/.local/bin/fpb
```
Source: https://github.com/rodrigopolo/fpb/releases

### Symbolic links in `~/.local/bin`
Just some examples
```sh
ln -s /Applications/MAMP/bin/php/php8.2.0/bin/php ~/.local/bin/php
ln -s /Applications/MAMP/Library/bin/mysql ~/.local/bin/mysql
ln -s /Applications/MAMP/Library/bin/mysqldump ~/.local/bin/mysqldump
ln -s /Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl ~/.local/bin/sublime
ln -s /opt/homebrew/bin/yt-dlp ~/.local/bin/youtube-dl
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

> **Setting HiDPI neccesary**
> ```sh
> brew install --cask betterdisplay
> brew uninstall --cask betterdisplay
> ```

## Dev

### Go

Install
```sh
brew install go
```

Create project
```sh
mkdir myproject
cd myproject
go mod init myproject
```

Run project
```sh
go run main.go
go build
```

### Rust

Install
```sh
# On macOS/Linux using rustup (recommended)
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# On Windows, download and run the installer from:
# https://www.rust-lang.org/tools/install
```

Create a new project
```sh
cargo new myproject
cd myproject

# This creates a basic structure with:
# - Cargo.toml (project configuration)
# - src/main.rs (main source file)
```

```sh
# Run the project
cargo run

# Build the project
cargo build

# Build an optimized release version
cargo build --release
```

### MongoDB Tools
```sh
brew tap mongodb/brew
brew install mongodb-database-tools
brew install mongosh
```

### Microsoft ODBC 18 on Apple Silicon

Remove previous installs
```sh
brew uninstall mssql-tools
brew uninstall mssql-tools18
brew uninstall msodbcsql17
brew uninstall msodbcsql18
brew uninstall mssql-tools
brew uninstall msodbcsql17
brew uninstall freetds
rm -rf /opt/homebrew/etc/freetds.conf
brew uninstall unixodbc
```

Install `unixodbc`, `msodbcsql18` and `mssql-tools18`

```sh
brew tap microsoft/mssql-release https://github.com/Microsoft/homebrew-mssql-release
brew update
HOMEBREW_ACCEPT_EULA=Y brew install msodbcsql18 mssql-tools18
```

Create custom SSL Conf
```sh
nano ~/.openssl.cnf
```

Enter the following
```sh
openssl_conf = default_conf

[default_conf]
ssl_conf = ssl_sect

[ssl_sect]
system_default = system_default_sect

[system_default_sect]
MinProtocol = TLSv1
CipherString = DEFAULT@SECLEVEL=0
```

Set the env var `$OPENSSL_CONF`
```sh
export OPENSSL_CONF=~/.openssl.cnf
```

Test connection
```sh
sqlcmd -S 192.168.1.5 -U abscript -P 'pass' -N -C
```

```sql
SELECT @@VERSION
go
```

Dependencias Python
```sh
pip install openpyxl
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

## Personalizations

### Sublime Text defaults

```json
{
  "draw_white_space": "all",
  "ignored_packages":
  [
    "Vintage",
  ],
  "wrap_width": 80,
  "open_files_in_new_window": false,
  "scroll_past_end": true,
  "show_encoding": true,
  "word_wrap": false,
  "rulers": [80],
  "index_files": true,
  "font_size": 12,
}
```

### Sublime Packages
```
MarkdownPreview.sublime-package
Sort Lines (Numerically).sublime-package
Sync View Scroll.sublime-package
```

### Lightroom Export Presets
```
~/Library/Application\ Support/Adobe/Lightroom/Export\ Presets/User\ Presets
```

### Misc
```
https://github.com/const-void/DOOM-fire-zig
Ctrl+R for search
```

### Browser Plug-ins

* Seek Subtitles for YouTube by J.Rajer  
  https://chrome.google.com/webstore/detail/seek-subtitles-for-youtub/ghjmdgljbfiiaginabfnaopnocgafffb  
* Chrome Regex Search  
  https://chrome.google.com/webstore/detail/chrome-regex-search/bpelaihoicobbkgmhcbikncnpacdbknn  
* Get cookies.txt Clean  
  https://chromewebstore.google.com/detail/get-cookiestxt-clean/ahmnmhfbokciafffnknlekllgcnafnie  
* Live Chat Overlay  
  https://chromewebstore.google.com/detail/live-chat-overlay/aplaefbnohemkmngdogmbkpompjlijia  
* Return YouTube Dislike  
  https://chrome.google.com/webstore/detail/return-youtube-dislike/gebbhagfogifgggkldgodflihgfeippi  
* EditThisCookie  
  https://addons.opera.com/en/extensions/details/edit-this-cookie/  
  https://www.editthiscookie.com/  
* Tampermonkey by derjanb  
  https://chrome.google.com/webstore/detail/tampermonkey/dhdgffkkebhmkfjojejmpbldmpobfkfo  
  https://addons.opera.com/en/extensions/details/tampermonkey-beta/  
  https://www.tampermonkey.net/  
Highlighter for Google Chrome™
  https://chrome.google.com/webstore/detail/highlighter-for-google-ch/lebapnohkilocjiocfcaljckcdoaciae  
  https://chrome.google.com/webstore/detail/highlighter/fdfcjfoifbjplmificlkdfneafllkgmn  
* Adblock Plus  
  https://adblockplus.org/  
* Instagram Downloader (IDL Helper)  
  https://addons.opera.com/en/extensions/details/instagram-downloader-idl-helper/  
* FoxyProxy Standard by Eric H. Jung  
  https://addons.mozilla.org/en-US/firefox/addon/foxyproxy-standard/  
* Telegram Video Downloader / Telegram Media Downloader  
  https://github.com/neet-nestor/telegram-media-downloader  