#!/bin/bash

# Daily Email Script
# Usage: Add the following line to crontab to run it every day at 7:30:
# 30 07 * * * daily-email-send.sh

logfile=/data/SCCData/daily-email/git.log
timestamp=$(date +"%D %T %Z %z")
echo -e "\n\n-------------- $timestamp --------------" 2>&1 | tee -a $logfile
echo -e "\n\nEmail Service:\n" 2>&1 | tee -a $logfile
touch /data/SCCData/daily-email/CatwalkDataFigures_$(date +'%Y-%m-%d').pdf
touch /data/SCCData/daily-email/MetDataFigures_$(date +'%Y-%m-%d').pdf
touch /data/SCCData/daily-email/WeirDataFigures_$(date +'%Y-%m-%d').pdf

EMAIL_SUBJECT="Daily FCR Forecasts"
EMAIL_BODY="Good morning, all.\n\nAttached are today's graphs.\n\nHave a wonderful day! :-)\n\nBests,\nBruno"
EMAIL_SELF=v.daneshmand@gmail.com
EMAIL_RECEPIENTS=scc-daily-email-g@vt.edu
EMAIL_ATTACHMENT1=/data/SCCData/daily-email/CatwalkDataFigures_$(date +'%Y-%m-%d').pdf
EMAIL_ATTACHMENT2=/data/SCCData/daily-email/MetDataFigures_$(date +'%Y-%m-%d').pdf
EMAIL_ATTACHMENT3=/data/SCCData/daily-email/WeirDataFigures_$(date +'%Y-%m-%d').pdf
#EMAIL_ATTACHMENT4=/home/scc/forecast/FCR_forecasts/v1.beta2/Current_forecast.png
#EMAIL_ATTACHMENT5=/home/scc/forecast/FCR_WQ_FORECAST_TESTING/Current_forecast_WQ.png
echo -e "$EMAIL_BODY" | sudo s-nail -v \
-A gmail \
-a $EMAIL_ATTACHMENT1 \
-a $EMAIL_ATTACHMENT2 \
-a $EMAIL_ATTACHMENT3 \
-s "$EMAIL_SUBJECT" \
$EMAIL_RECEPIENTS \
2>&1 | tee -a $logfile
cd /data/SCCData/daily-email/
/usr/bin/git pull 2>&1 | tee -a $logfile
/usr/bin/git add . 2>&1 | tee -a $logfile
/usr/bin/git commit -m "$timestamp: Daily Email" 2>&1 | tee -a $logfile
/usr/bin/git push 2>&1 | tee -a $logfile
