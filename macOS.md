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

Add a path to the Terminal into the `~/.zprofile` file:

```sh
path=( ~/bin $path )
```

Generate RSA Keys:

```sh
ssh-keygen -t rsa
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