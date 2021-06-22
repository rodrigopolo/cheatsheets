### Git

List git-ignored files
```bash
git ls-files . --ignored --exclude-standard --others
```

List untracked files
```bash
git ls-files . --exclude-standard --others
```

Reset to last commit
```bash
git reset --hard
```

Add files
```bash
git add path/file.txt
```

Remove file or files
```bash
git rm file
git rm -rf files
```

Revert Changes to File
```bash
git checkout -- <file>
```

Revert File to Previous Commit
```bash
$ git checkout <commit_hash> -- <file>
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
```bash
git mergetool
```

Generate and add key (Big Sur)
```sh
ssh-keygen -t ed25519 -C "your_email@example.com"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
```

Add key to a remote server, and set the permissions
```sh
nano authorized_keys
chmod 644 authorized_keys
```

View your key
```bash
cat ~/.ssh/id_ed25519.pub
```

Set your identity
```bash
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
```bash
git commit -m 'Info'
git push origin master

git checkout -b gh-pages
# or
git checkout gh-pages

git merge master
git push origin gh-pages
git checkout master
```

Create patch from last commit, add `~` for extra commits:
```bash
git format-patch HEAD~
```

Apply patch:
```bash
git am commit-name.patch
```

## NPM
```sh
npm login
git commit -m "Blah"
git tag v0.1.0
git push origin master --tags
npm publish
```

Source: https://codeburst.io/how-to-create-and-publish-your-first-node-js-module-444e7585b738