#!/bin/bash

# nrg-automated-net-test.sh
# Created by Joey Cherry for Western NRG

# Required (non standard) programs: Mtr, ifconfig, speedtest-cli, ssh/scp.

DATE=`date +"%H:%M:%S_%d-%m-%Y"`
TIME=`date +"%H:%M:%S"`
TITLE="nrg-automated-net-test-$DATE.txt"
BAR="=================================================="

DEFAULT_LOCATION="/tmp"
DEFAULT_ADDR="8.8.8.8"
DEFAULT_COUNT="1" #Testing


NOTE="Note: Using nrg-net-test to measure the quality of your network may result in decreased network performace, due to the significant amount of network traffic created. Furthermore, running this test on wifi will make this information meaningless. Press enter to continue:"


cd /tmp
touch $TITLE

echo $BAR >> $TITLE
echo $NOTE >> $TITLE
echo $BAR >> $TITLE
echo `ifconfig` >> $TITLE
echo $BAR >> $TITLE
echo `speedtest >> $TITLE` #https://www.howtoforge.com/tutorial/check-internet-speed-with-speedtest-cli-on-ubuntu/
echo $BAR >> $TITLE
echo "`mtr --report --report-cycle $DEFAULT_COUNT $DEFAULT_ADDR >> $TITLE`"
echo $BAR >> $TITLE
echo `scp -P 22 ./$TITLE pi@192.168.0.5:/tmp` #Change my values! http://www.howtogeek.com/66776/how-to-remotely-copy-files-over-ssh-without-entering-your-password/ Note: do not put passphrase on ALSO chmod 0644 is too weak, try 400 AND make it immutable
echo $BAR >> $TITLE
