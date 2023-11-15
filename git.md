# Git

### List git-ignored files
```sh
git ls-files . --ignored --exclude-standard --others
```

### List untracked files
```sh
git ls-files . --exclude-standard --others
```

### Reset to last commit
```sh
git reset --hard
```

### Reset specified file to last state
```sh
git checkout -- file.php 
```

### Add files
```sh
git add path/file.txt
```

### Remove file or files
```sh
git rm file
git rm -rf files
```

### Revert Changes to File
```sh
git checkout -- <file>
```

### Revert File to Previous Commit
```sh
$ git checkout <commit_hash> -- <file>
```

### Diff and Merge, edit `~/.gitconfig`
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

### Merge
```sh
git mergetool
```

### Generate and add key (Big Sur)
```sh
ssh-keygen -t ed25519 -C "your_email@example.com"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
```

### Add key to a remote server, and set the permissions
```sh
nano authorized_keys
chmod 644 authorized_keys
```

### View your key
```sh
cat ~/.ssh/id_ed25519.pub
```

### Set your identity
```sh
git config --global user.name "John Doe"
git config --global user.email johndoe@example.com
```

### Ignore file `.gitignore` example
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

### SSH Git using non standard ports, create alias on `~/.ssh/config` file:
```
Host bitbucket.org
        HostName altssh.bitbucket.org
        Port 443
```

### Sync GitHub pages method 1
```sh
git commit -m 'Info'
git push origin master

# New branch
git checkout -b gh-pages

# Switch to existing branch
git checkout gh-pages

git merge master
git push origin gh-pages
git checkout master
```

### Sync GitHub pages method 2
1. Go to the gh-pages branch
2. Bring gh-pages up to date with master
3. Commit the changes
4. Return to the master branch

```sh
git checkout gh-pages
git rebase master
git push origin gh-pages
git checkout master
```

### See local branches
```sh
git branch
```

### See remote branches:
```sh
git branch -r
```

### See all local and remote branches:
```sh
git branch -a
```

### Create new branch
```sh
git checkout -b <newbranch>
```

### Push to an scpecific branch
```sh
git push origin <branch>
```

### Switch to a branch
```sh
git checkout <branch>
```

### Create patch from last commit, add `~` for extra commits:
```sh
git format-patch HEAD~
```

### Apply patch:
```sh
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

### Non-git patchs

Create a patch and applying
```sh
diff -Naur original modified > patch.txt
patch original < patch.txt
```

Create, apply and undo
```sh
diff -u OriginalFile UpdatedFile > PatchFile
patch OriginalFile < PatchFile
patch -R OriginalFile < PatchFile
```

Source: https://www.shellhacks.com/create-patch-diff-command-linux/