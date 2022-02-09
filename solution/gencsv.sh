#!/bin/bash
num=0

Random=$$

while [ $num -lt 10 ]
do
echo "$num,$Random"
num=`expr $num + 1`
done>inputfile
