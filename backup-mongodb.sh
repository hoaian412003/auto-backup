#!/bin/bash

MONGO_USER="admin"
MONGO_PASSWORD="n#5v%1^81aLL^@xR"
BACKUP_DIRECTORY="$(pwd)/backup"
DATE=$(date +"%Y-%m-%d")
PWD=$(pwd)
SERVICE_NAME="bingo"
DATABASE=("binggo_dup" "binggo_test")

mkdir -p $BACKUP_DIRECTORY

for db in $DATABASE; do
	local SaveDir = "$BACKUP_DIRECTORY/$DATE-$db"
	echo "Starting backup databse $db ..."
	mongodump --db $db --out SaveDir
	echo "Backup done and save in $SaveDir"
	echo "Ziping SaveDir"
	zip -r "$SaveDir.zip" "$SaveDir"
	SaveDir = "$SaveDir.zip"
	# Push to S3
	echo "Pushing backup aws s3 cp SaveDir s3://backup-everyday/$SERVICE_NAME/"
	/usr/local/bin/aws s3 cp SaveDir s3://backup-everyday/$SERVICE_NAME/
	echo "Pushed done !"
done
