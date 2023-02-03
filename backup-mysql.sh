#!/bin/bash

MYSQL_USER="admin"
MYSQL_PASSWORD="n#5v%1^81aLL^@xR"
BACKUP_DIRECTORY="$(pwd)/backup"
DATE=$(date +"%Y-%m-%d")
PWD=$(pwd)
SERVICE_NAME="bingo"
DATA_BASE_NAME=("binggo_dup" "binggo_test")

mkdir -p $BACKUP_DIRECTORY

mysqldump -u $MYSQL_USER -p$MYSQL_PASSWORD $DATA_BASE_NAME > $BACKUP_DIRECTORY/$DATE.sql
echo "Backup at date $DATE"
echo "Backup dir is $BACKUP_DIRECTORY/$DATE.sql"
echo "Pushing backup aws s3 cp $BACKUP_DIRECTORY/$DATE.sql s3://backup-everyday/$SERVICE_NAME/"
/usr/local/bin/aws s3 cp $BACKUP_DIRECTORY/$DATE.sql s3://backup-everyday/$SERVICE_NAME/
echo "Pushed done !"
echo "Removing backup in local"
rm $BACKUP_DIRECTORY/$DATE.sql
echo "Remove done"
