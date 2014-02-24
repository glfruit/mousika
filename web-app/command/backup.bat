set PGPASSWORD=mousika_dev
"D:\Program Files\PostgreSQL\9.1/bin/pg_dump.exe" --host localhost --port 5432 --username "mousika_dev" --format custom --blobs --verbose --file "E:\projects\mousika\web-app\backup/mousika_dev-%date:~0,4%-%date:~5,2%-%date:~8,2%-%time:~0,2%-%time:~3,2%-%time:~6,2%.backup"
exit