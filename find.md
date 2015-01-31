### Find cheat sheets

Find and list PHP files on the current path containing `base64` keyword
```
find `pwd` -iname "*.php" -exec grep -i "base64" -l '{}' \; -print
```

Find folders to get folder size
```
find `pwd` -maxdepth 3 -type d -exec du -hs {} \;
```

Find excluding mounting points and ignoring errors
```
find `pwd` -mount -iname "file.txt" -print 2>/dev/null
```

Find and delete empty folders or empty files
```
find `pwd` -type d -empty -delete
find `pwd` -type f -empty -delete
```

Find and replace folder permissions for web folders
```
find `pwd` -type f -exec chmod 644 {} \; && find ./ -type d -exec chmod 755 {} \; && chmod 755 `pwd`
```

>Tip: You can use ``pwd`` to define current folder or type `./`