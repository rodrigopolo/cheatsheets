### MySQL Cheat Sheet

#### Connect
```
mysql -h [host] -u [user] -p[pass] [database]
```

#### Dump

Dump a complete host
```
mysqldump -h [host] -u [user] -p[pass] --all-databases > [all-database].sql
```

Dump a complete database
```
mysqldump -h [host] -u [user] -p[pass] --compact [database] > [database].sql
```

Dump only database data, without schema
```
-- Dump only data
mysqldump -h [host] -u [user] -p[pass] --skip-triggers --compact --no-create-info [database-data] > [database-data].sql
```

Dump only a table with `add-drop-table` command
```
mysqldump -h [host] -u [user] -p[pass] --add-drop-table [database] [table] > [table].sql
```

Dump table with `insert-ignore` command
```
mysqldump -h [host] -u [user] -p[pass] --compact --no-create-info --insert-ignore [database] [table] > [table].sql
```

Dump routines
```
mysqldump -h [host] -u [user] -p[pass] --routines --no-create-info --no-data --no-create-db --skip-opt --compact [database] > routines.sql
```

#### Restore

Restore from SQL file
```
mysql -h [host] -u [user] -p[pass] [database] < [script.sql] --default-character-set=utf8
```

#### Misc

Find and Replace
```
UPDATE [table_name] SET [field_name] = replace([field_name], 'string_to_find', 'string_to_replace');
```

Rename tables
```
RENAME TABLE [some_table] TO [new_name], [other_table] TO [other_new_name];
```

Reset `AUTO_INCREMENT` number
```
ALTER TABLE [table] AUTO_INCREMENT=0;
```

Fixing double-encoded UTF-8 data 
```
mysqldump -h [host] -u [user] -p[pass] --opt --quote-names \
    --skip-set-charset --default-character-set=latin1 [database] > [database].sql

mysql -h [host] -u [user] -p[pass] \
    --default-character-set=utf8 [database] < [database].sql
```