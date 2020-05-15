#!/bin/bash

# Git Garbage Collection Script
# Executd from the Gateway
# Runs Git Garbage Collector
# Usage: Add the following line to crontab to run it on the first day of each month at 12:00 AM
# 00 00 01 * * git-gc.sh

logfile=/data/$HOSTNAME-logs/git-gc.log
datadir=/data/$HOSTNAME-data
logdir=/data/$HOSTNAME-logs

timestamp=$(date +"%D %T %Z %z")

echo -e "\n\n#################################################################\n" 2>&1 | tee -a $logfile
echo -e "############## $HOSTNAME - $timestamp ##############" 2>&1 | tee -a $logfile
echo -e "\n#################################################################\n\n" 2>&1 | tee -a $logfile

cd $datadir
git gc --prune 2>&1 | tee -a $logfile

cd $logdir
git gc --prune 2>&1 | tee -a $logfile
