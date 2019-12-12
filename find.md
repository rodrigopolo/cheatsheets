### Find cheat sheets

Find and list PHP files on the current path containing `base64` keyword
```bash
find `pwd` -iname "*.php" -exec grep -i "base64" -l '{}' \; -print
```

Find folders to get folder size
```bash
find `pwd` -maxdepth 3 -type d -exec du -hs {} \;
```

Find excluding mounting points and ignoring errors
```bash
find `pwd` -mount -iname "file.txt" -print 2>/dev/null
```

Find and delete empty folders or empty files
```bash
find `pwd` -type d -empty -delete
find `pwd` -type f -empty -delete
```

Find and replace folder permissions for web folders
```bash
find `pwd` -type f -exec chmod 644 {} \; && find ./ -type d -exec chmod 755 {} \; && chmod 755 `pwd`
```

Change file dates
```bash
find "`pwd`" -type f -exec touch -c -t 201503151200 "{}" \;
```

>Tip: You can use ``pwd`` to define current folder or type `./`

Search with egrep and piping
```bash
cat file.txt | egrep "(\.jpe?g)" | grep word
```

File types
```bash
find . -type f | sed -e 's/.*\.//' | sort | uniq -c
```

Get file size with path
```bash
find "`pwd`" -type f -exec stat --printf="%n\t%s\n" '{}' \;
```

Rename
```bash
brew install ren
ren '*.jpg' '#1.webp'
```