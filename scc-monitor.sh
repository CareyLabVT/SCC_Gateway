#!/bin/bash

# Git Monitoring Script
# Usage: Add the following line to crontab to run it every hour:
# 00 * * * * monitor.sh

SCRIPT=/home/vahid/applications/scc-monitor/
LOGFILE=/home/vahid/applications/scc-monitor/scc-monitor.log
TIMESTAMP=$(date +"%D %T %z")
THRESHOLD=900
FLAGLIFE=1380 #Delay to check a failed repo (in minutes)
BASEPATH=/data
ERROR=0
EMAIL_BODY=""
declare -A repos
repos=(
#       [repo]=Update Interval in Seconds
        [SCCData/carina-data]=21600
        [SCCData/carina-logs]=21600
        [SCCData/mia-data]=21600
        [SCCData/mia-logs]=21600
        [noaa_gefs_forecasts/fcre]=43200
        [noaa_gefs_forecasts/sugg]=43200
        [noaa_gefs_forecasts/sunp]=43200
        [noaa_gefs_forecasts/cram]=43200
        [noaa_gefs_forecasts/tool]=43200
        [noaa_gefs_forecasts/prpo]=43200
)


function send_mail {
EMAIL_SUBJECT="SCC Monitor"
EMAIL_SELF=v.daneshmand@gmail.com
EMAIL_RECEPIENTS=cayelan@vt.edu,rqthomas@vt.edu,bethanyb18@vt.edu,vdaneshmand@ufl.edu
echo -e "$EMAIL_BODY" | sudo s-nail -v \
-A gmail \
-s "$EMAIL_SUBJECT" \
$EMAIL_RECEPIENTS \
2>&1 | tee -a $LOGFILE
}


function check_last_commit {
cd $BASEPATH/$1
git pull --no-edit

THEN=$(git log -1 --format=%cd --date=format:"%D %T %z")
NOW=$(date +"%D %T %z")
THEN_SEC=$(date -u -d "$THEN" +"%s")
NOW_SEC=$(date -u -d "$NOW" +"%s")
DIFF=$(($NOW_SEC-$THEN_SEC))

if [ $DIFF -gt $(($2+$THRESHOLD)) ]; then
        ERROR=1
        echo "Error"
        add_flag $1
        EMAIL_BODY=$EMAIL_BODY"Branch: $1\nExpected Push Interval: $(($2/86400))d:$(($2%86400/3600))h:$(($2%3600/60))m:$(($2%60))s\nElapsed Time from Last Commit: $(($DIFF/86400))d:$(($DIFF%86400/3600))h:$(($DIFF%3600/60))m:$(($DIFF%60))s\n\n"
fi
}


function monitor_repo {
echo "#################################"
echo "#####$TIMESTAMP#####"
echo "#################################"

for key in ${!repos[@]}; do
        echo -e "\n${key}"
        if [ -f $SCRIPT`echo "${key////_}"".flag"` ]
        then
                echo "Check within $FLAGLIFE Minutes"
        else
                echo "Fresh Check"
                check_last_commit ${key} ${repos[${key}]}
        fi
done

if [ $ERROR -eq 1 ]; then
        send_mail ${key} ${repos[${key}]}
fi
}


function add_flag {
touch $SCRIPT`echo "${1////_}"".flag"`
}


function del_flag {
find $SCRIPT -name *.flag -type f -mmin +$1 -delete
}


monitor_repo 2>&1 | tee -a $LOGFILE
del_flag $FLAGLIFE
