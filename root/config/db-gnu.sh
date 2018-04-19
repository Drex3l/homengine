#!/bin/bash

stty -echo
printf "Enter MySQL Root Password: "
read  passvar
echo
mysql -uroot -p$passvar < ../usr/sql/db-admin.sql
mysql -uroot -p$passvar  < ../usr/sql/world.sql
mysql -uroot -p$passvar  < ../usr/sql/db-schema.sql
mysql -uroot -p$passvar homengine < ../usr/sql/db-data.sql
