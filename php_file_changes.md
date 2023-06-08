### Script to detect changes in your PHP files

#### 1) Create your shell script and save it:


```bash
#!/usr/bin/env bash

# Cron Script Path
CRON_PATH=/the_working_directory_of_your_cronjob_where_logs_will_be_saved
SCAN_PATH=/the_path_you_want_to_watch

# Go to cron directory to store data there
cd $CRON_PATH

# Set dates
TODAY=`date +%Y%m%d`
DA1=`date --date="1 days ago" +"%Y%m%d"`
DA2=`date --date="2 days ago" +"%Y%m%d"`

# Remove old logs
rm $DA2.log

# Make a list of the files
find $SCAN_PATH -type f -iname "*.php" -exec ls -l {} \; | awk '{ print $9 "\t" $5 }' > $TODAY.log

# Compare the list with the previous list
diff --side-by-side --suppress-common-lines $DA1.log $TODAY.log 1>&2
```

This bash script will scan all your files `.php` and it will create a `log` file
where it will store each path to each file and the file size, then, it will 
compare the new file against the previous file to check for any difference and 
then and output differences to STDERR, if no difference is found it will not 
return any result.

#### 2) Give your shell script execution permissions:

```bash
chmod +x script.sh
```

#### 3) Create your cronjob, first create a text file to store your crontab:

```bash
touch crontab.txt
```

#### 4) Edit your file and enter the following changing the path to your shell script and your email:

```bash
SHELL="/bin/bash"
# Mail
MAILTO="email@example.com"

# Modified files daly report
00 0 * * * /path_to_your/shell_script.sh
```

This cronjob script will execute your shell script, and if it receives any data 
into the STDERR it will send an email to the address above, so lets add this 
file to the crontab:

```bash
crontab crontab.txt
```

Done, to check if the crontab is created type:

```bash
crontab -l
```