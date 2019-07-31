Proccess management

View processes
```
top
htop
```

Install
```
sudo apt-get install htop
brew install htop
```

List all processes
```
ps -A
```

List processes tree
```
pstree
```

Stop a process with a PID
```
kill <PID>
```

Stop a process with a name
```
pkill safari
killall safari
```

List processes with a global regular expression print
```
pgrep -i safari
```

Change process priority (sudo maybe needed)
```
renice 19 PID
```
