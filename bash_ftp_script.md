### FTP Upload Script

Automated FTP upload on Linux
```bash
#!/bin/bash

####################
# Set FTP Settings
####################

# Host
FTP_HOST="example.com"

# User
FTP_USER="user_name"

# Pass
FTP_PASS="pass"

# Path to upload into (a path that exists)
FTP_DEST=/ftp/folder/$2

# FTP Destination folder
FTP_FILE_DEST=/var/www/html/backups/$2


##########
# Script
##########

if [ -z "$1" ] || [ -z "$2" ]; then
        echo "File to upload not defined"
        echo "Usage: ./script.sh file.txt"
        exit 1
else
cd $FTP_FILE_DEST
ftp -n -v $FTP_HOST << EOT
ascii
user $FTP_USER $FTP_PASS
prompt
cd $FTP_DEST
put $1
bye
EOT
fi
```