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

```sh
FILE="example.tar.gz"

echo "${FILE%%.*}"
# example

echo "${FILE%.*}"
# example.tar

echo "${FILE#*.}"
# tar.gz

echo "${FILE##*.}"
# gz
```

https://stackoverflow.com/a/965069/218418

Sequences
```sh
#!/usr/bin/env zsh

# Sequence
list=$( echo {10..100..10} )
echo $list

# loop Sequence
for num in {10..100..10}
do
	echo $num
done
```

A backup `backup.sh` script
```sh
#!/usr/bin/env bash

# Root check
if [[ $EUID -ne 0 ]]; then
	echo "Este script debe ejecutarse con permisos root." 
	exit 1
else

	# Argument loop
	for USERNAME in "$@"; do

		CURRENT_USER="/Users/$USERNAME"

		# Check if dir exists
		if [ -d "$CURRENT_USER" ]; then

			echo "########## USUARARIO: $USERNAME ##########"

			TODAY=$(date "+%Y-%m-%d_%H%M%S")

			DESTINATION="/tmp/${USERNAME}_home_${TODAY}.tar.gz"

			TOTAL_FILES=$(find "$CURRENT_USER" -type f | wc -l)
			TOTAL_DIRS=$(find "$CURRENT_USER" -type d | wc -l)

			echo "Archivos a ser incluidos $TOTAL_FILES"
			echo "Directorios a ser incluidos $TOTAL_DIRS"

			tar -czf "$DESTINATION" -P "$CURRENT_USER"

			TAR_FILE_INFO=$(ls -la $DESTINATION)

			TOTAL_GZFILES=$(tar -tvf "$DESTINATION" | grep -E "^[^d]" | wc -l)
			TOTAL_GZDIRS=$(tar -tvf "$DESTINATION" | grep -E "^d" | wc -l)

			echo "Archivos archivados: $TOTAL_GZFILES"
			echo "Directorios archivados: $TOTAL_GZDIRS"
			echo "Backup $CURRENT_USER completado!"
			echo "Detalles del archivo de backup generado:"
			echo $TAR_FILE_INFO

		else
			# Report user not found
			echo "El usuario \"$USERNAME\" no existe."
		fi
	done

fi

```

A permissions `perm.sh` script
```sh
#!/usr/bin/env bash

CURRENT_USER=$(whoami)

if [ -z "$1" ]; then
	echo "No se ingresó ningun argumento."
else

	if test -f "$1"; then
		echo "######### Nombre archivo analizado: $1 ###########"

		if [ -r "$1" ]; then
			echo "*El usuario: $CURRENT_USER tiene permiso de lectura"
		else
			echo "*El usuario: $CURRENT_USER NO tiene permiso de lectura"
		fi

		if [ -w "$1" ]; then
			echo "*El usuario: $CURRENT_USER tiene permiso de escritura"
		else
			echo "*El usuario: $CURRENT_USER NO tiene permiso de escritura"
		fi

		if [ -x "$1" ]; then
			echo "*El usuario: $CURRENT_USER tiene permiso de escritura"
		else
			echo "*El usuario: $CURRENT_USER NO tiene permiso de escritura"
		fi

	else
		echo "Archivo \"$1\" no existe."
	fi

fi

```

A Linux distro info script
```sh
#!/usr/bin/env bash
KV=$(uname -r)
. /etc/os-release
echo "El nombre de la distribucion es: $PRETTY_NAME"
echo "La version del sistema operativo es: $VERSION_ID"
echo "La version del kernel actual es: $KV"
echo "Puede consultar la documentacion de la distribucion en: $SUPPORT_URL"

```

## Crontab

> On macOS you should give full disk access permissions to Terminal.app and `/usr/sbin/cron` in System Settings, Privacy.

Commands
```sh
# List crontab
crontab -l

# Clean the crontab
crontab -r

# Replace crontab with a contab file
crontab CrontabFile.txt

# Edit crontab manualy
crontab -e
```

Set the shell, and an email to receive cron output
```sh
SHELL="/bin/bash"
# Mail for errors and output
# MAILTO="email@domain.com"
```

Run every day at 4am at Guatemala local time
```sh
TZ=America/Guatemala
0 4 * * * your_command
```

Run every 5 minutes, detaching the process from the crontab
```sh
# Time Zone
TZ=America/Guatemala

# Command to run every 5 minutes
*/5 * * * * nohup /path/to/script.sh & disown
```

A crontab example
> At minute 0 past every hour from 15 through 17 on Wednesday, Thursday, and Friday in every month from August through December.
```
0 15-17 * 8-12 3,4,5 	/path/to/script
```
https://cron.help/#0_15-17_*_8-12_3,4,5  
https://crontab.guru/#0_15-17_*_8-12_3,4,5  
