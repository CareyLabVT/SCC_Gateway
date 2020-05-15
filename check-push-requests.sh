#!/bin/bash

# On-demand Git Push Script
# Executd from the Master Node
# Checks for any updates in push.md file as the sign of an on-demand push request. If any, runs `git.sh` on gateways.
# Usage: Add the following line to crontab to run it every 5 minutes:
# */5 * * * * check-push-requests.sh

timestamp=$(date +"%D %T")
logfile=~/applications/on-demand-push/SCCData/push.log

echo -e "\nBruno,$timestamp" 2>&1 | tee -a $logfile

cd ~/applications/on-demand-push/SCCData
if [ -z "$(git pull | grep push.md)" ]; then
  echo "Not Updated" 2>&1 | tee -a $logfile;
else
  echo "Updated" 2>&1 | tee -a $logfile;
  ssh scc@192.168.10.11 /home/scc/applications/git.sh 2>&1 | tee -a $logfile
  ssh scc@192.168.10.12 /home/scc/applications/git.sh 2>&1 | tee -a $logfile
  echo -e "\nBruno,$timestamp" 2>&1 | tee -a $logfile
  git add ~/applications/on-demand-push/SCCData/push.md
  git commit -m "$timestamp: On-demand Push"
  git push
fi
