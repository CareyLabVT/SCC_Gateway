#!/bin/bash

# NOAA Download and Push Script
# Usage: Add the following line to crontab to run it every 6 hours:
# 00 /6 * * * noaa-git.sh

LOGFILE=/data/NOAA/logs/git.log
TIMESTAMP=$(date +"%D %T")

echo -e "\n\n-------------- $TIMESTAMP --------------" 2>&1 | tee -a $LOGFILE

echo -e "\n\nPull the R Script from GitHub:\n" 2>&1 | tee -a $LOGFILE

cd /data/NOAA/source
git add .
git commit -m "$TIMESTAMP: Commit Local Changes on Bruno"
git pull --no-edit 2>&1 | tee -a $LOGFILE
~/applications/git-retry.sh push -f 2>&1 | tee -a $LOGFILE
echo -e "\n" 2>&1 | tee -a $LOGFILE
for i in *.R; do Rscript $i 2>&1 | tee -a $LOGFILE; done

echo -e "\n\nGitHub Server:\n" 2>&1 | tee -a $LOGFILE

cd /data/NOAA/fcre
git add .
git commit -m "$TIMESTAMP: Git Backup" 2>&1 | tee -a $LOGFILE
git pull --no-edit 2>&1 | tee -a $LOGFILE
~/applications/git-retry.sh push -f 2>&1 | tee -a $LOGFILE

cd /data/NOAA/sugg
git add .
git commit -m "$TIMESTAMP: Git Backup" 2>&1 | tee -a $LOGFILE
git pull --no-edit 2>&1 | tee -a $LOGFILE
~/applications/git-retry.sh push -f 2>&1 | tee -a $LOGFILE

cd /data/NOAA/sunp
git add .
git commit -m "$TIMESTAMP: Git Backup" 2>&1 | tee -a $LOGFILE
git pull --no-edit 2>&1 | tee -a $LOGFILE
~/applications/git-retry.sh push -f 2>&1 | tee -a $LOGFILE

cd /data/NOAA/cram
git add .
git commit -m "$TIMESTAMP: Git Backup" 2>&1 | tee -a $LOGFILE
git pull --no-edit 2>&1 | tee -a $LOGFILE
~/applications/git-retry.sh push -f 2>&1 | tee -a $LOGFILE

cd /data/NOAA/tool
git add .
git commit -m "$TIMESTAMP: Git Backup" 2>&1 | tee -a $LOGFILE
git pull --no-edit 2>&1 | tee -a $LOGFILE
~/applications/git-retry.sh push -f 2>&1 | tee -a $LOGFILE

cd /data/NOAA/prpo
git add .
git commit -m "$TIMESTAMP: Git Backup" 2>&1 | tee -a $LOGFILE
git pull --no-edit 2>&1 | tee -a $LOGFILE
~/applications/git-retry.sh push -f 2>&1 | tee -a $LOGFILE

echo -e "\n\nPush the Logs to GitHub:\n" 2>&1 | tee -a $LOGFILE

cd /data/NOAA/logs
git add .
git commit -m "$TIMESTAMP: Logs" 2>&1 | tee -a $LOGFILE
git pull --no-edit 2>&1 | tee -a $LOGFILE
~/applications/git-retry.sh push -f 2>&1 | tee -a $LOGFILE
git add .
git commit -m "$TIMESTAMP: Logs" 2>&1 | tee -a $LOGFILE
~/applications/git-retry.sh push -f 2>&1 | tee -a $LOGFILE
