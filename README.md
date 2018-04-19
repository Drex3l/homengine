# homengine
``` 
property listing search engine 
```

## Description

The **homengine** is a web service for listing properties and finding properties. 
This project is opensource, powered by the **LAMP** statck, and versioned by **Git**.

## Installation
Clone this repository to your document root, and with web services running on your localhost, try accessing website from your web browser with the loopback address.
```
NOTE: Some systems might require user to append colon, followed by port number, to loopback address, when accessing a website in Document Root.
```
### Requirements
* Apache2 (web server)
* MariaDB/MySQL 5.7 (database server)
* PHP 7.0 (server-side scripting)
* Git (version control system)

### File System
Your web server needs to be given privileges to allow full control of the homengine and it's sub directories.
Originaly, the actual root of the homengine directory should contain the following files (in **bold** are directories)
* **root/**
* **.git/**
* index.php
* README.md
* .gitignore

Accessing website from web browser should created the 'connection.ini' file, inside the **root/config/** path. Use this file to give values of the connection string.
```ini
[SQL]
host = <database host ip address>
user = <database username>
password = <database user password>
dbname = <database schema>
```
### Database
The subdirectory **root/config/** also contails files that set up the homengine database using files found in the **root/usr/sql/** path.

These files assume that the path to MariaDB/MySQL **bin** directory has been added to the **Environment Variable**.
If not, please see manual of your system on how to do so, before executing these files.

#### GNU/Linux systems
The **db-gnu.sh** shell script must be executed from the **root/config/** working directory, for it use **relative paths** from its directory to reference files in the **root/usr/sql/** path. Executing this shell script from a different working directory will result in a "FILE NOT FOUND" exception.
This script is designed to work with bash , and related shells.

#### Windows system
Executing the **db-windows.bat** batch file opens a terminal window that prompts MySql root password, to perform the same function as the **db-gnu.sh** shell script, but on Windows systems.

#### SQL files
The subdirectory **root/usr/sql/** contails the following **.sql** files.
* db-admin.sql (creates database user and grants SELECT to 'world' database)
* world.sql	(as downloaded from the mysql.com)
* db-schema.sql	(creates relevant schema objects)
* db-data.sql	(provides required data)

