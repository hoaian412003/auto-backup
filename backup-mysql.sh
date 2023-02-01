#!/bin/bash

MYSQL_USER="admin"
MYSQL_PASSWORD="n#5v%1^81aLL^@xR"
BACKUP_DIRECTORY="$(pwd)/backup"
DATE=$(date +"%Y-%m-%d")
PWD=$(pwd)
SERVICE_NAME="bingo"

mkdir -p $BACKUP_DIRECTORY

mysqldump -u $MYSQL_USER -p$MYSQL_PASSWORD --all-databases > $BACKUP_DIRECTORY/$DATE.sql
echo "Backup at date $DATE"
echo "Backup dir is $BACKUP_DIRECTORY/$DATE.sql"
echo "Pushing backup aws s3 cp $BACKUP_DIRECTORY/$DATE.sql s3://backup-everyday/$SERVICE_NAME/"
/usr/local/bin/aws s3 cp $BACKUP_DIRECTORY/$DATE.sql s3://backup-everyday/$SERVICE_NAME/
echo "Pushed done !"
