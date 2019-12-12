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