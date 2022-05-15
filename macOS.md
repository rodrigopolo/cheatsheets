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

Add paths to system:
```sh
touch ~/.zshrc
nano ~/.zshrc 
```

```sh
export PATH=~/.bin:/usr/local/sbin:$PATH
export HOMEBREW_EDITOR=/usr/bin/nano
```

Generate and add key (Big Sur)
```sh
ssh-keygen -t ed25519 -C "your_email@example.com"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
```

Add key to a remote server, and set the permissions
```sh
nano authorized_keys
chmod 644 authorized_keys
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

Script `label` to change Finder color tag:
```sh
#!/bin/bash
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
ln -s /Applications/MAMP/Library/bin/mysql ~/.bin/mysql
ln -s /Applications/MAMP/Library/bin/mysqldump ~/.bin/mysqldump
ln -s /Applications/MAMP/bin/php/php7.3.24/bin/php ~/.bin/php
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
