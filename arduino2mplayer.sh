#!/bin/bash

USAGE="arduino2mplayer.sh [pipe in (/dev/ttyUSB0)] [pipe out (f1)] "

if [ $# -lt 2 ]
then
    echo ${USAGE}
    exit
else
    IN=$1
    OUT=$2
fi

while read i
do S=`echo ${i} | head -c1`
    if [ "${S}" == "1" ]
    then
	echo "pausing_keep_force pt_step 1" > ${OUT}
	echo "get_property pause" > ${OUT}
    elif [ "${S}" == "2" ]
    then
	echo "pausing_keep_force pt_step -1" > ${OUT}
	echo "get_property pause" > ${OUT}
    fi
done < ${IN}
