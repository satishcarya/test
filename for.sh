#!/bin/bash
j=0
i=0
for i in `cat t.op`
do
echo "current variable value of J is : $j"
echo "current variable value of I is : $i" 
j=$(expr $j+$i)
echo "New value of I is $i"

done
