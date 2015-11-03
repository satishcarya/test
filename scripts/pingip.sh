#!/bin/sh
#Pings all the IPs in a /24 network
COUNT=0
X=100
while [ $X -lt 149 ]
do
ping -c 1 "192.168.1.$X"
if [ $? = 0 ];
then
echo "192.168.1.$X is alive"
COUNT=$(($COUNT + 1))
fi
X=$((X+1))
done
echo $COUNT hosts responded
