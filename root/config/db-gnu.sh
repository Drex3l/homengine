#!/bin/bash

read -p 'Is your MySQL root user password protected?[y/N]: ' haspass
haspass=`echo $haspass | tr '[A-Z]' '[a-z]'` #transform value to lower case

while [ $haspass != "y" ] && [ $haspass != "n" ]; do
	echo option not understood!
	echo please use Y or N
	echo
	read -p 'Is your MySQL root user password protected?[y/N]: ' haspass
done

if [ "$haspass" = "y" ]; then
	stty -echo
	printf "Enter MySQL Root Password: "
	read  passvar
	echo
	mysql -uroot -p$passvar < ../usr/sql/db-admin.sql
	mysql -uroot -p$passvar  < ../usr/sql/world.sql
	mysql -uroot -p$passvar  < ../usr/sql/db-schema.sql
	mysql -uroot -p$passvar homengine < ../usr/sql/db-data.sql
else
	mysql -uroot  < ../usr/sql/db-admin.sql
        mysql -uroot  < ../usr/sql/world.sql
        mysql -uroot  < ../usr/sql/db-schema.sql
        mysql -uroot homengine < ../usr/sql/db-data.sql
fi
