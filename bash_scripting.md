To get the script location:
```sh
#!/usr/bin/env bash
SCRIPTPATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
```

Get current working directory
```sh
#!/usr/bin/env bash
CWD=`pwd -P`
```

[Simple loop](https://stackoverflow.com/a/41904013/218418)
```sh
FilesFound=$(find . -name "*.txt")

IFSbkp="$IFS"
IFS=$'\n'
counter=1;
for file in $FilesFound; do
    echo "${counter}: ${file}"
    let counter++;
done
IFS="$IFSbkp"
```