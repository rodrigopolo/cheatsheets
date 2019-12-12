To get the script location:
```bash
#!/usr/bin/env bash
SCRIPTPATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
```

Get current working directory
```bash
#!/usr/bin/env bash
CWD=`pwd -P`
```