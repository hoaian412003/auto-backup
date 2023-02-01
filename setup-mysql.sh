#!/bin/bash

check_installed(){
	local package=$1
	if which $package >/dev/null 2>&1; then
	  echo "$package is installed"
	  return 0
	else
	  echo "$package is not installed, installing"
	  return 1
	fi
}

echo "Checking cron is installed"
check_installed "cron"
if [ $? -ne 0 ]; then
	chmod +x ./install-cron.sh && ./install-cron.sh
fi

check_installed "mysql"
if [ $? -ne 0 ]; then
	return
fi

chmod +x ./backup-mysql.sh

pwd=$(pwd)
echo "Pushing command to cron job"
crontab -l > mycron
echo "0 0 * * * $pwd/backup-mysql.sh >> $pwd/log" >> mycron
crontab mycron
rm mycron
echo "Pushed command to cron job"
echo "Log file is: $pwd/log"
