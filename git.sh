#!/bin/bash

# Git Script
# Usage: Add the following line to crontab to run it every 6 hours:
# 00 /6 * * * git.sh

dataloggerdir=/data/CR3000Data
logfile=/data/carina-logs/git.log
datadir=/data/carina-data
logdir=/data/carina-logs

timestamp=$(date +"%D %T %Z %z")

echo -e "\n\n#################################################################\n" 2>&1 | tee -a $logfile
echo -e "############## $HOSTNAME - $timestamp ##############" 2>&1 | tee -a $logfile
echo -e "\n#################################################################\n\n" 2>&1 | tee -a $logfile

echo -e "GitHub:\n" 2>&1 | tee -a $logfile

cd $datadir
git pull 2>&1 | tee -a $logfile
cp -rf $dataloggerdir/* $datadir
git add . 2>&1 | tee -a $logfile
git commit -m "$timestamp: Git Backup" 2>&1 | tee -a $logfile
git push 2>&1 | tee -a $logfile

echo -e "\n\nGateway:\n" 2>&1 | tee -a $logfile

cd $logdir
git pull 2>&1 | tee -a $logfile
git add . 2>&1 | tee -a $logfile
git commit -m "$timestamp: Logs" 2>&1 | tee -a $logfile
git push &>> $logfile
git add . 2>&1 | tee -a $logfile
git commit -m "$timestamp: Logs" 2>&1 | tee -a $logfile
git push 2>&1 | tee -a $logfile
