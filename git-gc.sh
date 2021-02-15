#!/bin/bash

# Git Garbage Collection Script
# Executd from the Gateway
# Runs Git Garbage Collector
# Usage: Add the following line to crontab to run it on the first day of each month at 12:00 AM
# 00 00 01 * * git-gc.sh

location=fcre-catwalk
logfile=/data/$HOSTNAME-logs/git-gc.log
datadir=/data/$location-data
logdir=/data/$HOSTNAME-logs
#git_exec=/home/scc/applications/git-retry.sh

timestamp=$(date +"%D %T %Z")

echo -e "############################ $HOSTNAME - $timestamp ############################" 2>&1 | tee -a $logfile

echo "Disk Usage before Git Garbage Collection:"
df -h | grep /data 2>&1 | tee -a $logfile

cd $datadir
echo "Working on: $(pwd)"
git gc --prune 2>&1 | tee -a $logfile

cd $logdir
echo "Working on: $(pwd)"
git gc --prune 2>&1 | tee -a $logfile

echo "Disk Usage after Git Garbage Collection:"
df -h | grep /data 2>&1 | tee -a $logfile
