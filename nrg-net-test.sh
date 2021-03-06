#!/bin/bash

# nrg-net-test.sh
# Created by Joey Cherry for Western NRG

# Required (non standard) programs: Mtr, ifconfig, speedtest-cli, ssh/scp.

DATE=`date +"%H:%M:%S_%d-%m-%Y"`
TIME=`date +"%H:%M:%S"`
TITLE="nrg-net-test-$DATE.txt"

NOTE="Note: Using nrg-net-test to measure the quality of your network may result in decreased network performace, due to the significant amount of network traffic created. Furthermore, running this test on wifi (or with the built in raspberrypi NIC with connections faster than 100mbps up/down) will make this information worthless. Press enter to continue:"

echo `clear`
echo "NRG-NET-TEST started at: $TIME"

read -p "Where would you like to save the output of this file? Please use full path to location or this will not work. (Recommended is /tmp): " LOCATION
cd $LOCATION
touch $TITLE


echo "========================="$TIME"=========================" >> $TITLE

echo $NOTE
echo $NOTE >> $TITLE
read PAUSE

echo "==================================================" >> $TITLE

echo `ifconfig` >> $TITLE

echo "==================================================" >> $TITLE

echo "Running speedtest. Please be patient."
echo `speedtest >> $TITLE` #https://www.howtoforge.com/tutorial/check-internet-speed-with-speedtest-cli-on-ubuntu/
echo "Complete"

echo "==================================================" >> $TITLE

read -p "Where would you like to test against? (Recommended is: 8.8.8.8): " MTR1
read -p "How many times would you like to test? (Recommended is: 10): " MTR2
echo "This may take some time, please be patient."
echo `mtr --report --report-cycle $MTR2 $MTR1 >> $TITLE`

echo "==================================================" >> $TITLE

echo "Finished. Would you like to view the logs? y / n"
read ANSWER1
if [ $ANSWER1 == "y" ]; then
	fold -s $TITLE
fi

echo "Would you like to send the logs to WesternNRG's Servers? y / n"
read ANSWER2
if [ $ANSWER2 == "y" ]; then
	echo `scp -P 22 ./$TITLE pi@192.168.0.5:/tmp` #Change my values! http://www.howtogeek.com/66776/how-to-remotely-copy-files-over-ssh-without-entering-your-password/ Note: do not put passphrase on ALSO chmod 0644 is too weak, try 400 AND make it immutable
	echo "File saved on WesternNRG's servers and saved localy to $LOCATION"
else
	echo "File saved localy to $LOCATION"
fi
