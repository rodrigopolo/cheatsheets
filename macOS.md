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
