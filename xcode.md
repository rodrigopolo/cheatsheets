# XCode Simlulator

list devices
```
xcrun simctl list devices
```

Remove old devices for runtimes that are no longer supported
```
xcrun simctl delete unavailable
```

Delete specific device
```
xcrun simctl delete <ID>
```

Boot device
```
xcrun simctl boot <ID>
```

Record simulator video
```
xcrun simctl io booted recordVideo — type=mp4 ./test.mp4 
```

Make screenshot of simulator
```
xcrun simctl io booted screenshot ./screen.png
```

Open URL in simulator
```
xcrun simctl openurl booted https://google.com 
```

Upload photo or video file (for photos app)
```
xcrun simctl addmedia booted ./test.mp4
```

Find the app container (where identifier is like *com.bundle.identifier*)
```
xcrun simctl get_app_container booted <your apps bundle identifier> to 
```

To explore more commands
```
xcrun simctl help 
```


