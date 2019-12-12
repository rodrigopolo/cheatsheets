### MySQL Cheat Sheet

#### Connect
```bash
mysql -h [host] -u [user] -p[pass] [database]
```

#### Dump

Dump a complete host
```bash
mysqldump -h [host] -u [user] -p[pass] --all-databases > [all-database].sql
```

Dump a complete database
```bash
mysqldump -h [host] -u [user] -p[pass] --compact [database] > [database].sql
```

Dump only database data, without schema
```bash
-- Dump only data
mysqldump -h [host] -u [user] -p[pass] --skip-triggers --compact --no-create-info [database-data] > [database-data].sql
```

Dump only a table with `add-drop-table` command
```bash
mysqldump -h [host] -u [user] -p[pass] --add-drop-table [database] [table] > [table].sql
```

Dump table with `insert-ignore` command
```bash
mysqldump -h [host] -u [user] -p[pass] --compact --no-create-info --insert-ignore [database] [table] > [table].sql
```

Dump routines
```bash
mysqldump -h [host] -u [user] -p[pass] --routines --no-create-info --no-data --no-create-db --skip-opt --compact [database] > routines.sql
```

#### Restore

Restore from SQL file
```bash
mysql -h [host] -u [user] -p[pass] [database] < [script.sql] --default-character-set=utf8
```

#### Misc

Find and Replace
```sql
UPDATE [table_name] SET [field_name] = replace([field_name], 'string_to_find', 'string_to_replace');
```

Rename tables
```sql
RENAME TABLE [some_table] TO [new_name], [other_table] TO [other_new_name];
```

Reset `AUTO_INCREMENT` number
```sql
ALTER TABLE [table] AUTO_INCREMENT=0;
```

Fixing double-encoded UTF-8 data 
```bash
mysqldump -h [host] -u [user] -p[pass] --opt --quote-names \
    --skip-set-charset --default-character-set=latin1 [database] > [database].sql

mysql -h [host] -u [user] -p[pass] \
    --default-character-set=utf8 [database] < [database].sql
```

Distance function
```sql
-- Meters: 6371000, Miles: 3959000
DELIMITER $$
DROP FUNCTION IF EXISTS `DISTANCE_BETWEEN` $$
CREATE FUNCTION DISTANCE_BETWEEN (
  lat1 float(10,6), lon1 float(10,6),
  lat2 float(10,6), lon2 float(10,6)
) RETURNS DOUBLE DETERMINISTIC
BEGIN
  return ACOS(SIN(lat1*PI()/180)*SIN(lat2*PI()/180)
    + COS(lat1*PI()/180)*COS(lat2*PI()/180)
    * COS(lon2*PI()/180-lon1*PI()/180))
    * 6371000
END $$
DELIMITER ;
```

Create view
```sql
DROP TABLE IF EXISTS `myview`;
DROP VIEW  IF EXISTS `myview`;
CREATE VIEW `myview` AS 
  SELECT * from `table`;
```
