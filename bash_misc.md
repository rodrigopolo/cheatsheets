### Bash misc

Compress file or folder to file.tar.gz
```
tar -czf file.tar.gz directory/
tar -czf file.tar.gz file.txt
```

Tar without compression
```
tar -cf file.tar.gz directory/
```

Uncompress TAR and BZ files
```
tar xzf file.tar.gz
tar xjf file.tar.bz2
```

ZIP compress
```
zip -r file.zip folder
```

ZIP Uncompress
```
unzip file.zip
```

ZIP without OS X Files
```
zip -r -X file.zip folder
```

Remove a folder
```
rm -rf folder/
```

Copy folder A to folder B
```
cp -R -p /FolderA/* /FolderB
```

Move from current folder to parent folder
```
cd path/to/folder
mv * ../
```

Change file date
```
touch -t 201306141200 
```

Download a file on Linux and OS X
```
wget http://example.com/file.txt
curl -O http://example.com/file.txt
```

Change file or permissions
```
chmod 777 file
chmod -R 777 ./dir
```

Change to executable
```
chmod 0750 file
chmod +x file
```

Change file owner
```
chown -R owner ./dir
chown owner file
```

Change current user password and other user password
```
passwd
passwd USER
```

Find and kill a process
```
ps -A | grep <PROCESS>
kill -9 <PROCESS ID>
```

Check free hardrive space
```
df -h
```

Shutdown
```
sudo poweroff
```