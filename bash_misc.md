### Bash misc

Compress file or folder to file.tar.gz
```bash
tar -czf file.tar.gz directory/
tar -czf file.tar.gz file.txt
```

Tar without compression
```bash
tar -cf file.tar.gz directory/
```

Uncompress TAR and BZ files
```bash
tar xzf file.tar.gz
tar xjf file.tar.bz2
```

Compress file types
```bash
find . -name "*.jpg" | tar -czf jpgs.tar.gz -T -
```

ZIP compress
```bash
zip -r file.zip folder
```

ZIP Uncompress
```bash
unzip file.zip
```

ZIP without OS X Files
```bash
zip -r -X file.zip folder
```

Find inside files
```bash
find `pwd` -type f -iname "*.js" -exec grep -i "keyword" -l '{}' \; -print
```


Remove a folder
```bash
rm -rf folder/
```

Copy folder A to folder B
```bash
cp -R -p /FolderA/* /FolderB
```

Move from current folder to parent folder
```bash
cd path/to/folder
mv * ../
```

Change file date
```bash
touch -t 201306141200 
```

Download a file on Linux and OS X
```bash
wget http://example.com/file.txt
curl -O http://example.com/file.txt
```

Change file or permissions
```bash
chmod 777 file
chmod -R 777 ./dir
```

Change to executable
```bash
chmod 0750 file
chmod +x file
```

Change file owner
```bash
chown -R owner ./dir
chown owner file
```

Change current user password and other user password
```bash
passwd
passwd USER
```

Find and kill a process
```bash
ps -A | grep <PROCESS>
kill -9 <PROCESS ID>
```

Check free hardrive space
```bash
df -h
```

Shutdown
```bash
sudo poweroff
```

Timestamps with [ISO 8601](http://www.w3.org/TR/NOTE-datetime)

With timezone
```bash
date +%Y-%m-%dT%H:%M:%S%:z
```
UTC
```bash
date -u +%Y-%m-%dT%H:%M:%SZ
```

For filenames
```bash
date -u +%Y-%m-%dT%H.%M.%SZ
```

Get file creation and modification date
```bash
stat -f "Access (atime): %Sa%nModify (mtime): %Sm%nChange (ctime): %Sc%nBirth  (Btime): %SB"
```

Get folder size on OS X by file size, NOT disk usage
```bash
find . -type f -print0 | xargs -0 stat -f%z | awk '{b+=$1} END {print b}'
```

Get folder size on Linux by file size, NOT disk usage
```bash
find . -type f -print0 | xargs -0 stat -c%s | awk '{b+=$1} END {print b}'
```

Clear history and logout
```bash
rm ~/.bash_history; history -c; logout
```

Replace text using `sed`
```bash
sed -e 's/hello/hola/g;s/world/mundo/g;' < file.txt > out.txt
```

Replace ext. using `sed`
```bash
for i in *.md; do echo "$i" "$( sed -e 's/\.md$/.txt/g' <<< $i )"; done
for i in *.md; do echo "$i" "`sed -e 's/\.md$/.txt/g' <<< $i`"; done
```

Remove file in paths, sort, inque, grep results
```bash
cat todo.txt | sed 's:[^/]*$::' | sort | uniq |grep -i keyword
```

Replace `./` with `md5sum`
```bash
sed -i -e 's/\.\//md5sum /g' files.txt
```

Replace last character with `]`
```bash
sed '$ s/.$/\]/' input.json > output.json
```

Convert a list of objects into a JSON file by adding commas on each line and `[]`
```bash
sed '1s;^;\[;' input.json | sed '$ s/.$/\]/' > output.json
```

Break JSONs into lines and clean last object "fo"
```bash
sed -E $'s/(fo\"\:[0-9]+\},)(\{)/\\1\\\n\\2/g' "./ricigt1/followers.json" | \
sed -E $'s/(,\"fo\"\:[0-9]+)//g' > "./ricigt1/ricigt1-followers.json"

sed -E $'s/(fo\"\:[0-9]+\},)(\{)/\\1\\\n\\2/g' "./ricigt1/friends.json" | \
sed -E $'s/(,\"fo\"\:[0-9]+)//g' > "./ricigt1/ricigt1-friends.json"
```

Remove duplicates and convert one line intwo two lines for `aria2c` to download
```bash
cat file | sort | uniq | sed -E $'s/\|/\\\n  out=/g' > uris.txt
aria2c -j 16 -i uris.txt
```

Check difference between two files
```bash
diff --side-by-side --suppress-common-lines file1.txt file2.txt
```

https://www.cyberciti.biz/faq/bash-prepend-text-lines-to-file/
https://www.geeksforgeeks.org/sed-command-in-linux-unix-with-examples/

Redirects:
```bash
> redirects stdout to file
1> redirects stdout to file
2> redirects stderr to file
&> redirects stdout and stderr to file
```

Run command in the background, discard stdout and stderr
```bash
command > /dev/null 2>&1 &
```

Run command and append stdout and stderr to a log file.
```bash
command >> /path/to/log 2>&1 &
```

Delete history and exit
```bash
cat /dev/null > ~/.bash_history && history -c && exit
```

Redirect `stdout` and `stderr` to files
```sh
command > stdout 2> stderr
```