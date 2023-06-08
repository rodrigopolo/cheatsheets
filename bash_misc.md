### Bash misc

Compress file or folder to archive.tar.gz
```sh
tar -czf file.tar.gz directory/
tar -czf file.tar.gz file.txt
```

* `tar`: the command for creating a tar archive
* `-c`: create a new archive
* `-z`: compress the archive using gzip
* `-v`: show verbose output (optional)
* `-f`: specify the output filename
* `archive.tar.gz`: the name of the output file
* `directory/`: the directory to be compressed

Tar without compression
```sh
tar -cf file.tar.gz directory/
```

Uncompress TAR and BZ files
```sh
tar xzf file.tar.gz
tar xjf file.tar.bz2
```

Compress file types
```sh
find . -name "*.jpg" | tar -czf jpgs.tar.gz -T -
```

ZIP compress
```sh
zip -r file.zip folder
```

ZIP Uncompress
```sh
unzip file.zip
```

ZIP without OS X Files
```sh
zip -r -X file.zip folder
```

Find a string inside files, getting only the files matchinig
```sh
# With xargs
find "$(pwd)" -type f -iname "*.md" -print0 | xargs -0 grep -l -i "keyword"
find "$(pwd)" -type f -iname "*.md" -print0 | xargs -0 grep -zi "keyword" --files-with-matches

# Using exec, getting duplicate lines
find "$(pwd)" -type f -iname "*.js" -exec grep -i "keyword" -l '{}' \; -print
```

Find a string inside files, getting only the files matchinig, with the line and match text
```sh
find "$(pwd)" -type f -iname "*.md" -print0 | xargs -0 grep -n -H -i "keyword"
```

Find all HTML files and extract the anchors
```sh
find . -type f -iname "*.html" | \
xargs -I {} grep -o -E "<a[^>]*>[^<]*<\/a>" {} | \
sort | \
uniq
```

Untested Alternative via ChatGPT
```sh
grep -o '<a[^>]*href="[^"]*"' file.html | sed -e 's/<a[^>]*href="//' -e 's/"//' 
```

Find all HTML files and extract all the URLs
```sh
find . -type f -iname "*.html" | \
xargs -I {} pcregrep -o1 '<a\b[^>]?href="([^"]*)"' {} | \
sort | \
uniq
```

Untested Alternative 1 via ChatGPT
```sh
find . -type f -name '*.html' \
-exec grep -Eo 'href="[^"]*"' {} \; | \
sed -e 's/href="//g' -e 's/"//g'
```

Untested Alternative 2 via ChatGPT
```sh
find . -type f -iname "*.html" -print0 | \
xargs -0 grep -Eo '<a[^>]+href="([^"]+)"' | \
sed -E 's/<a[^>]+href="([^"]+)"/\1/g' | \
sort -u
```

Remove a folder
```sh
rm -rf folder/
```

Copy folder A to folder B
```sh
cp -R -p /FolderA/* /FolderB
```

Move from current folder to parent folder
```sh
cd path/to/folder
mv * ../
```

Change file date
```sh
touch -t 201306141200 
```

Download a file on Linux and OS X
```sh
wget http://example.com/file.txt
curl -O http://example.com/file.txt
```

Change file or permissions
```sh
chmod 777 file
chmod -R 777 ./dir
```

Create a symbolic link
```sh
ln -s /path/to/original ~/.bin/symlink
```

The chmod command is used to change the permissions of a file or directory. The three numbers that follow the "chmod" command represent the permissions for the owner, the group, and others.

Each number is a combination of three digits, ranging from 0 to 7. Each digit represents a different permission:

The first digit represents the permissions for the owner of the file.
The second digit represents the permissions for the group that the file belongs to.
The third digit represents the permissions for all other users.
Each digit can be a combination of the following values:

* 0: No permission
* 1: Execute permission
* 2: Write permission
* 3: Write and execute permissions
* 4: Read permission
* 5: Read and execute permissions
* 6: Read and write permissions
* 7: Read, write, and execute permissions

Change to executable
```sh
chmod 0750 file
chmod +x file
```

Change file owner
```sh
chown -R owner ./dir
chown owner file
```

Change current user password and other user password
```sh
passwd
passwd USER
```

Find and kill a process
```sh
ps -A | grep <PROCESS>
kill -9 <PROCESS ID>
```

Check free hardrive space
```sh
df -h
```

Shutdown
```sh
sudo poweroff
```

Timestamps with [ISO 8601](http://www.w3.org/TR/NOTE-datetime)

With timezone
```sh
date +%Y-%m-%dT%H:%M:%S%:z
date +"%Y-%m-%dT%H:%M:%S%z"
```

UTC
```sh
date -u +%Y-%m-%dT%H:%M:%SZ
```

For filenames
```sh
date -u +%Y-%m-%dT%H.%M.%SZ
```

Get file creation and modification date
```sh
stat -f "Access (atime): %Sa%nModify (mtime): %Sm%nChange (ctime): %Sc%nBirth  (Btime): %SB"
```

Created and modified
```sh
stat -f "Created: %SB%nModified: %Sm" <file>
```

Get folder size on OS X by file size, NOT disk usage
```sh
find . -type f -print0 | xargs -0 stat -f%z | awk '{b+=$1} END {print b}'
```

Untested ChatGPT alternative
```sh
find . -type f -exec stat -c%s {} + | awk '{b+=$1} END {print b}'
```

Get folder size on Linux by file size, NOT disk usage
```sh
find . -type f -print0 | xargs -0 stat -c%s | awk '{b+=$1} END {print b}'
```

Clear history and logout
```sh
rm ~/.bash_history; history -c; logout
```

Open nano in line 10
```sh
nano +10 example.txt
```

Replace text using `sed`
```sh
sed -e 's/hello/hola/g;s/world/mundo/g;' < file.txt > out.txt
```

Replace ext. using `sed`
```sh
for i in *.md; do echo "$i" "$( sed -e 's/\.md$/.txt/g' <<< $i )"; done
for i in *.md; do echo "$i" "`sed -e 's/\.md$/.txt/g' <<< $i`"; done
```

Remove file in paths, sort, inque, grep results
```sh
cat todo.txt | sed 's:[^/]*$::' | sort | uniq |grep -i keyword
```

Untested ChatGPT alternative
```sh
awk -F/ '/keyword/ {print $1"/"}' todo.txt | sort -u
grep -r -i -l keyword todo.txt | xargs -I{} dirname {} | sort -u
find . -name "todo.txt" -exec dirname {} \; | sort -u | xargs -I{} grep -li keyword {}/todo.txt
```

Replace `./` with `md5sum`
```sh
sed -i -e 's/\.\//md5sum /g' files.txt
```

Replace last character with `]`
```sh
sed '$ s/.$/\]/' input.json > output.json
```

Convert a list of objects into a JSON file by adding commas on each line and `[]`
```sh
sed '1s;^;\[;' input.json | sed '$ s/.$/\]/' > output.json
```

Break JSONs into lines and clean last object "fo"
```sh
sed -E $'s/(fo\"\:[0-9]+\},)(\{)/\\1\\\n\\2/g' "json1.json" | \
sed -E $'s/(,\"fo\"\:[0-9]+)//g' > "json2.json"
```

Remove duplicates and convert one line intwo two lines for `aria2c` to download
```sh
cat file | sort | uniq | sed -E $'s/\|/\\\n  out=/g' > uris.txt
aria2c -j 16 -i uris.txt
```

Split files
```sh
gsplit -l 500 -d -a 6 file.txt newname_ --additional-suffix=.txt
```

Pass the 3 argument from a file to xargs and then execute echo
```sh
cut -f3 < file.txt | xargs -P 5 -I {} mycommand "?{}?"
```

Untested ChatGPT alternative
```sh
cut -f3 < file.txt | parallel -j 5 mycommand "?{}?"
```

Change prompt
```sh
export PS1=">"; clear;
PROMPT='%/ %# '
PROMPT='%~ %# '
PROMPT='%F{blue}%1~%f %# '
PROMPT='%(?.√.?%?) %1~ %# ' 
PROMPT='%(?.%F{green}√.%F{red}?%?)%f %B%F{240}%1~%f%b %# ' 
```
https://scriptingosx.com/2019/07/moving-to-zsh-06-customizing-the-zsh-prompt/


Check difference between two files
```sh
diff --side-by-side --suppress-common-lines file1.txt file2.txt
```

Create patch file
```sh
diff -u OriginalFile UpdatedFile > PatchFile
```

Apply patch
```sh
patch OriginalFile < PatchFile
```

Undo patch
```sh
$ patch -R OriginalFile < PatchFile
```

https://www.shellhacks.com/create-patch-diff-command-linux/
https://www.cyberciti.biz/faq/bash-prepend-text-lines-to-file/
https://www.geeksforgeeks.org/sed-command-in-linux-unix-with-examples/

Redirects:
```sh
> redirects stdout to file
1> redirects stdout to file
2> redirects stderr to file
&> redirects stdout and stderr to file
```

Run command in the background, discard stdout and stderr
```sh
command > /dev/null 2>&1 &
```

Run command in the background using `nohup` and `disown`
```sh
nohup /path/to/script.sh &; disown; exit
```

Alternatives
```sh
./my_script.sh &
nohup ./my_script.sh &
```

Run command and append stdout and stderr to a log file.
```sh
command >> /path/to/log 2>&1 &
```

Delete history and exit
```sh
cat /dev/null > ~/.bash_history && history -c && exit
```

Securely delete files inside a directory and ensure that they cannot be recovered
```sh
shred -u -n 5 /path/to/directory/*
```

Alternative
```sh
srm -r mydir
```

Redirect `stdout` and `stderr` to files
```sh
command > stdout 2> stderr
```

Count lines
```sh
cat file | wc -l
```