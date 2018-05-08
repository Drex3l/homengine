@echo off
set /p hasPass=" Do you have MySql root Password?[y/N] "
::set pass=
IF /I "%hasPass%"=="Y" (

	set /p pass=" Enter MySql root Password: "
	ECHO ON
	mysql -uroot -p%pass% < ..\usr\sql\db-admin.sql
	mysql -uroot -p%pass% < ..\usr\sql\world.sql
	mysql -uroot -p%pass% < ..\usr\sql\db-schema.sql
	mysql -uroot -p%pass% homengine < ..\usr\sql\db-data.sql

) ELSE (
	ECHO ON
	mysql -uroot  < ..\usr\sql\db-admin.sql
	mysql -uroot  < ..\usr\sql\world.sql
	mysql -uroot  < ..\usr\sql\db-schema.sql
	mysql -uroot  homengine < ..\usr\sql\db-data.sql

)
