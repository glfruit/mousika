@echo off
:1
if "%1"=="h" goto :2
mshta vbscript:createobject("wscript.shell").run(""%0"h",0)(window.close)&&exit
:2
set PGPASSWORD=mousika_dev
"D:/Program Files/PostgreSQL/9.1/bin/pg_dump.exe" --host localhost --port 5432 --username "mousika_dev" --format custom --blobs --verbose --file "C:\mousika_dev-%date:~0,4%-%date:~5,2%-%date:~8,2%-%time:~0,2%-%time:~3,2%-%time:~6,2%.dump"
exit