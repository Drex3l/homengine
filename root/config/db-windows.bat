@echo off
set /p pass=" Enter MySql root Password: "

mysql -uroot -p%pass% < ..\usr\sql\db-admin.sql
mysql -uroot -p%pass% < ..\usr\sql\world.sql
mysql -uroot -p%pass% < ..\usr\sql\db-schema.sql
mysql -uroot -p%pass% homengine < ..\usr\sql\db-data.sql
