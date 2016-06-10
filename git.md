### Git

List git-ignored files
```
git ls-files . --ignored --exclude-standard --others
```

List untracked files
```
git ls-files . --exclude-standard --others
```

Reset to last commit
```
git reset --hard
```

Add files
```
git add path/file.txt
```

Remove file or files
```
git rm file
git rm -rf files
```

Diff and Merge, edit ~/.gitconfig
```
[merge]
        tool = kdiff3
[mergetool "kdiff3"]
        path = c:/Program Files/KDiff3/kdiff3.exe
[diff]
        tool = kdiff3
        guitool = kdiff3
[difftool "kdiff3"]
        path = c:/Program Files/KDiff3/kdiff3.exe
[core]
	editor = c:/Program Files (x86)/Subtitle Edit/SubtitleEdit.exe
```

> KDiff3 [download](http://kdiff3.sourceforge.net/).

Merge
```
git mergetool
```

Generate key
```
ssh-keygen -t rsa -C "your_email@example.com"
```

View your key
```
cat ~/.ssh/id_rsa.pub
```

Set your identity
```
git config --global user.name "John Doe"
git config --global user.email johndoe@example.com
```

Ignore file `.gitignore` example
```
# Designers
*.psd

#OS junk files
[Tt]humbs.db
*.DS_Store

# Sync Tools
sync.ffs_db

# Damn dreamweaver
*_notes/

# Builds
/build/OTAInstall
/build/StandardInstall

# Config files
config.php
config.json
```

SSH Git using non standard ports, create alias on `~/.ssh/config` file:
```
Host bitbucket.org
        HostName altssh.bitbucket.org
        Port 443
```

GitHub pages
```
git commit -m 'Info'
git push origin master
git checkout gh-pages
git merge master
git push origin gh-pages
git checkout master
```