#!/bin/bash

# System Monitor Script
# Usage: Add the following line to crontab to run it every 6 hours:
# 00 /6 * * * monitor.sh

logfile=/data/$HOSTNAME-logs/monitor.log
datadir=/data/$HOSTNAME-data
logdir=/data/$HOSTNAME-logs
timestamp=$(date +"%D %T %Z %z")

echo -e "\n" 2>&1 | tee -a $logfile
echo -e "\n\n#################################################################\n" 2>&1 | tee -a $logfile
echo -e "############## $HOSTNAME - $timestamp ##############" 2>&1 | tee -a $logfile
echo -e "\n#################################################################\n\n" 2>&1 | tee -a $logfileecho -e "\n" 2>&1 | tee -a $logfile
uptime 2>&1 | tee -a $logfile
echo -e "\n" 2>&1 | tee -a $logfile
/usr/bin/last reboot | head -n 10 2>&1 | tee -a $logfile
echo -e "\n" 2>&1 | tee -a $logfile
/usr/bin/lsusb | grep Novatel 2>&1 | tee -a $logfile
echo -e "\n" 2>&1 | tee -a $logfile
dmesg | grep enx 2>&1 | tee -a $logfile
echo -e "\n" 2>&1 | tee -a $logfile
dmesg | tail 2>&1 | tee -a $logfile
echo -e "\n" 2>&1 | tee -a $logfile
df -h 2>&1 | tee -a $logfile
echo -e "\n" 2>&1 | tee -a $logfile
/sbin/ip addr show enx0015ff030033 | grep 'enx0015ff030033' | awk '{print $2}' 2>&1 | tee -a $logfile
echo -e "\n" 2>&1 | tee -a $logfile
/sbin/ip addr show enx0015ff025968 | grep 'enx0015ff025968' | awk '{print $2}' 2>&1 | tee -a $logfile
echo -e "\n" 2>&1 | tee -a $logfile
/sbin/ip addr show enx0015ff080733 | grep 'enx0015ff080733' | awk '{print $2}' 2>&1 | tee -a $logfile
echo -e "\n" 2>&1 | tee -a $logfile
/sbin/ip addr show ipop | grep 'ipop' | awk '{print $2}' 2>&1 | tee -a $logfile
echo -e "\n" 2>&1 | tee -a $logfile
/sbin/ip addr show enp2s0 | grep 'enp2s0' | awk '{print $2}' 2>&1 | tee -a $logfile
echo -e "\n" 2>&1 | tee -a $logfile
systemctl status watchdog.service 2>&1 | tee -a $logfile
echo -e "\n" 2>&1 | tee -a $logfile
systemctl status ipopTincan.service 2>&1 | tee -a $logfile
echo -e "\n" 2>&1 | tee -a $logfile
systemctl status ipopController.service 2>&1 | tee -a $logfile
echo -e "\n" 2>&1 | tee -a $logfile
ping -c 3 8.8.8.8 2>&1 | tee -a $logfile
echo -e "\n" 2>&1 | tee -a $logfile
ping -c 3 192.168.10.2 2>&1 | tee -a $logfile
echo -e "\n" 2>&1 | tee -a $logfile
ping -c 3 192.168.10.11 2>&1 | tee -a $logfile
echo -e "\n" 2>&1 | tee -a $logfile
ping -c 3 192.168.10.12 2>&1 | tee -a $logfile
echo -e "\n" 2>&1 | tee -a $logfile
ping -c 3 192.168.10.13 2>&1 | tee -a $logfile
echo -e "\n" 2>&1 | tee -a $logfile
ping -c 3 github.com 2>&1 | tee -a $logfile
