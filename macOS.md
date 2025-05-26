# macOS Utilities

### Create disk image from folder
```bash
hdiutil create \
-fs HFS+ \
-srcfolder /path/to/folder \
-volname "Volume Name" \
"image_file.dmg"
```

### Create bootable disk
```bash
sudo \
/Applications/Install\ macOS\ Sierra.app/Contents/Resources/createinstallmedia \
--volume /Volumes/VolumeName \
--applicationpath /Applications/Install\ macOS\ Sierra.app \
--nointeraction
```

### Prevent external disks from sleeping
```sh
sudo pmset -a disksleep 0
```

### Reset defaults Launchpad
```sh
defaults write com.apple.dock ResetLaunchPad -bool true; killall Dock
```

### Remove [ugly blue capslock indicator](https://discussions.apple.com/thread/255191086?sortBy=best)
```sh
sudo defaults write /Library/Preferences/FeatureFlags/Domain/UIKit.plist redesigned_text_cursor -dict-add Enabled -bool NO
```

### Set volume from terminal
```sh
sudo osascript -e "set Volume 10"
```

### Speak
```sh
say -v Alex "I'm setting up all the remote connections"
```

### List available voices
```sh
say -v '?'
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

find . -type f -exec xattr -d com.apple.quarantine "{}" +
find . -type d -exec xattr -d com.apple.quarantine "{}" +
```

### unimatrix
```sh
sudo curl -L https://raw.githubusercontent.com/will8211/unimatrix/master/unimatrix.py -o /usr/local/bin/unimatrix
sudo chmod a+rx /usr/local/bin/unimatrix
unimatrix -s 90
```

### Matrix
```sh
cmatrix
unimatrix -s 90
```
https://github.com/will8211/unimatrix

### Figlet
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

### Slugify
```sh
pip install python-slugify
slugify "Rodrigo Polo"
```

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

## Warp theme `~/.warp/themes/rodrigopolo.yaml`
```yaml
---
background: '#1e1e1e' # Terminal background color
accent: '#268bd2' # Accent color for UI elements
foreground: '#ffffff' # The foreground color
details: darker # Whether the theme is lighter or darker
#cursor: '#98989d' # The cursor color (optional; defaults to accent color if omitted)
terminal_colors: # Ansi escape colors
  bright:
    black: '#575653'
    red: '#de352e'
    green: '#1dd361'
    yellow: '#f3bd09'
    blue: '#1e97df'
    magenta: '#bf25f1'
    cyan: '#259fe6'
    white: '#ffffff'
  normal:
    black: '#1a1a1a'
    red: '#ed1b21'
    green: '#2dc55e'
    yellow: '#ecba0f'
    blue: '#2a84d2'
    magenta: '#a716e4'
    cyan: '#168cda'
    white: '#83868e'
name: Rodrigo Polo
```
