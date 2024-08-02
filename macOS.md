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
touch ~/.zshrc
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

Set defaults of Sublime Text into the `~/Library/Application Support/Sublime Text 3/Packages/User` file:

```json
{
	"draw_white_space": "all",
	"ignored_packages":
	[
		"Vintage"
	],
	"open_files_in_new_window": false,
	"scroll_past_end": true,
	"show_encoding": true
}
```

Reset defaults Launchpad
```sh
defaults write com.apple.dock ResetLaunchPad -bool true; killall Dock
```

Remove [ugly blue capslock indicator](https://discussions.apple.com/thread/255191086?sortBy=best)
```sh
sudo defaults write /Library/Preferences/FeatureFlags/Domain/UIKit.plist redesigned_text_cursor -dict-add Enabled -bool NO
```

Script `label` to change Finder color tag:
```sh
#!/usr/bin/env bash
if [[ $# -le 1 || ! "$1" =~ ^[0-7]$ ]]; then
  echo "Usage: label 01234567 file ..." 1>&2
  exit 1
fi

colors=( 0 2 1 3 6 4 5 7 )
n=${colors[$1]}
shift

osascript - "$@" <<END > /dev/null 2>&1
on run arguments
tell application "Finder"
repeat with f in arguments
set f to (posix file (contents of f) as alias)
set label index of f to $n
end repeat
end tell
end
END
```

```
0 = No label
1 = Red
2 = Orange
3 = Yellow
4 = Green
5 = Blue
6 = Purple
7 = Gray
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

### Custom `~/.bin`

Symbolic links in ~/.apps/
```sh
ln -s /Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl ~/.bin/sublime
ln -s /Applications/MAMP/Library/bin/mysql ~/.bin/mysql
ln -s /Applications/MAMP/Library/bin/mysqldump ~/.bin/mysqldump
ln -s /Applications/MAMP/bin/php/php7.4.21/bin/php ~/.bin/php
```

### Composer
```sh
cd && curl -sS https://getcomposer.org/installer | php
mv composer.phar ~/.bin/composer
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
