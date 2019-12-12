Proccess management

View processes
```bash
top
htop
```

Install
```bash
sudo apt-get install htop
brew install htop
```

List all processes
```bash
ps -A
```

List processes tree
```bash
pstree
```

Stop a process with a PID
```bash
kill <PID>
```

Stop a process with a name
```bash
pkill safari
killall safari
```

List processes with a global regular expression print
```bash
pgrep -i safari
```

Change process priority (sudo maybe needed)
```bash
renice 19 PID
```
