#!/bin/bash

MONGO_USER="admin"
MONGO_PASSWORD="n#5v%1^81aLL^@xR"
BACKUP_DIRECTORY="$(pwd)/backup"
DATE=$(date +"%Y-%m-%d")
PWD=$(pwd)
SERVICE_NAME="vote_battle_dev"
DATABASE=("vote_battle")

mkdir -p $BACKUP_DIRECTORY

for db in $DATABASE; do
	SaveDir="$BACKUP_DIRECTORY/$DATE/$db"
	echo "Starting backup databse $db ..."
	mkdir -p "$BACKUP_DIRECTORY/$DATE"
	mongodump --db $db --out SaveDir --username $MONGO_USER --password $MONGO_PASSWORD
	echo "Backup done and save in $SaveDir"
	echo "Ziping SaveDir"
	zip -r "$SaveDir.zip" "$SaveDir"
	SaveDir="$SaveDir.zip"
	# Push to S3
	echo "Pushing backup aws s3 cp $SaveDir s3://backup-everyday/$SERVICE_NAME/"
	/usr/local/bin/aws s3 cp $SaveDir s3://backup-everyday/$SERVICE_NAME/
	echo "Pushed done !"
done
