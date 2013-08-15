CURTIME=`date +"%Y-%m-%d-%H-%M-%S"`
export PGPASSWORD=mousika_dev
pg_dump --host localhost --port 5432 --username "mousika_dev" --format custom --blobs --verbose --file "E:\projects\mousika/backup/mousika_dev-$CURTIME.backup"
exit