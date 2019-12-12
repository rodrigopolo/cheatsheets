### Daemonize Cheat Sheet

#### Windows
Download [NSSM](http://nssm.cc/download)

Run Command Prompt as an administrator and type:
```cmd
nssm.exe install [ServiceName]
```

On the `NSSM` window, enter the following info

Application
```
Path: C:\path\to\file.exe
Startup directory: C:\path\to\
Arguments: arg1 arg2
```

Details
```
Display name: [ServiceName]
Description: [A Description]
```

I/O
```
Output: C:\path\to\stdout.log
Error: C:\path\to\stderr.log
```

#### To start your service
```cmd
net start [ServiceName]
```

#### Uninstall service

```cmd
net stop [ServiceName]
nssm remove [ServiceName]
```

#### OS X

Create a Launch daemon
```bash
sudo nano  /Library/LaunchDaemons/org.yourdaemon.plist
```

Paste your custom XML
```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
        <dict>
                <key>Label</key>
                <string>org.yourdaemon.proxy</string>
                <key>RunAtLoad</key>
                <true/>
                <key>ProgramArguments</key>
                <array>
                        <string>/path/to/bin/file</string>
                        <string>arg1</string>
                        <string>arg2</string>
                        <string>arg3</string>
                </array>
                <key>RunAtLoad</key>
                <true/>
                <key>KeepAlive</key>
                <false/>
                <key>WorkingDirectory</key>
                <string>/path/to/working/directory/</string>
                <key>StandardErrorPath</key>
                <string>/path/to/err.log</string>
                <key>StandardOutPath</key>
                <string>/path/to/out.log</string>
        </dict>
</plist>
```

Change permissions, load and start
```bash
sudo /usr/sbin/chown root:wheel /Library/LaunchDaemons/org.yourdaemon.plist
sudo /bin/launchctl load /Library/LaunchDaemons/org.yourdaemon.plist
sudo /bin/launchctl start org.yourdaemon
```

Stop and Remove
```bash
sudo /bin/launchctl stop org.yourdaemon
sudo /bin/launchctl unload /Library/LaunchDaemons/org.yourdaemon.plist
sudo rm /Library/LaunchDaemons/org.yourdaemon.plist
```

