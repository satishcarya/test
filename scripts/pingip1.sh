ngs all the IPs in a /24 network
COUNT=0
X=1
while [ $X -lt 255 ]
do
ping -c 1 "$1.$X"
if [ $? = 0 ];
then
echo "$1.$X is alive"
COUNT=$(($COUNT 1))
fi
X=$((X+1))
done
echo $COUNT hosts responded
