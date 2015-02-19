## Edit Message of the Day (MOTD) in Ubuntu

Edit the file `/etc/pam.d/sshd`.

```
sudo nano /etc/pam.d/sshd
```

Find the following lines
```
session    optional     pam_motd.so  motd=/run/motd.dynamic noupdate
session    optional     pam_motd.so # [1]
```

If you like, can change the order or comment the first one:
```
session    optional     pam_motd.so # [1]
session    optional     pam_motd.so  motd=/run/motd.dynamic noupdate
```

Edit/create your message file:
```
sudo nano /etc/motd
```

Paste what you like into the file:
```
  __  ____             __         __ __________
 / / / / /  __ _____  / /___ __  / //_  __/ __/
/ /_/ / _ \/ // / _ \/ __/ // / / /__/ / _\ \  
\____/_.__/\_,_/_//_/\__/\_,_/ /____/_/ /___/  

```

Restart your SSH service:
```
sudo service ssh restart
```

## Edit Message of the Day (MOTD) in OS X

Edit the `/etc/motd` file.
```
sudo nano /etc/motd
```

Paste your massage
```
 __  __                  _ __     
 \ \/ /__  ______ __ _  (_) /____ 
  \  / _ \(_-< -_)  ' \/ / __/ -_)
  /_/\___/___|__/_/_/_/_/\__/\__/ 
                                  
```
