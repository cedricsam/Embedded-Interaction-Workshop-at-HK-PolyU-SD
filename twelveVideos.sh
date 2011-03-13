#!/bin/bash

for i in `seq 0 12`
do
	stty -F /dev/ttyUSB${i} cs8 9600 ignbrk -brkint -imaxbel -opost -onlcr -isig -icanon -iexten -echo -echoe -echok -echoctl -echoke noflsh -ixon -crtscts
done

# Videos
VID0=http://localhost:8080/stream
VID1=http://localhost:8082/stream
#VID0=${HOME}/Desktop/google.mp4
#VID1=${HOME}/Desktop/nexus.mp4

# Common MPlayer commands
MPOPTS="-noborder -nocache -nosound -xineramascreen 1"

# Basic values
XOFF=0 # offset
YOFF=0
W=160
H=160

let X0=0
let X1=${W}
let X2=${W}*2
let X3=${W}*3
let Y0=0
let Y1=${H}
let Y2=${H}*2
let XX0=${X0}+${XOFF}
let XX1=${X1}+${XOFF}
let XX2=${X2}+${XOFF}
let XX3=${X3}+${XOFF}
let YY0=${Y0}+${YOFF}
let YY1=${Y1}+${YOFF}
let YY2=${Y2}+${YOFF}

# row 1
C1="${W}:${H}:${X0}:${Y0}"
C2="${W}:${H}:${X1}:${Y0}"
C3="${W}:${H}:${X2}:${Y0}"
C4="${W}:${H}:${X3}:${Y0}"
# row 2
C5="${W}:${H}:${X0}:${Y1}"
C6="${W}:${H}:${X1}:${Y1}"
C7="${W}:${H}:${X2}:${Y1}"
C8="${W}:${H}:${X3}:${Y1}"
# row 3
C9="${W}:${H}:${X0}:${Y2}"
C10="${W}:${H}:${X1}:${Y2}"
C11="${W}:${H}:${X2}:${Y2}"
C12="${W}:${H}:${X3}:${Y2}"

# row 1
G1="${XX0}:${YY0}"
G2="${XX1}:${YY0}"
G3="${XX2}:${YY0}"
G4="${XX3}:${YY0}"
# row 2
G5="${XX0}:${YY1}"
G6="${XX1}:${YY1}"
G7="${XX2}:${YY1}"
G8="${XX3}:${YY1}"
# row 3
G9="${XX0}:${YY2}"
G10="${XX1}:${YY2}"
G11="${XX2}:${YY2}"
G12="${XX3}:${YY2}"

# row 1
OPT1="-vf crop=${C1} -geometry ${G1}"
OPT2="-vf crop=${C2} -geometry ${G2}"
OPT3="-vf crop=${C3} -geometry ${G3}"
OPT4="-vf crop=${C4} -geometry ${G4}"
# row 2
OPT5="-vf crop=${C5} -geometry ${G5}"
OPT6="-vf crop=${C6} -geometry ${G6}"
OPT7="-vf crop=${C7} -geometry ${G7}"
OPT8="-vf crop=${C8} -geometry ${G8}"
# row 3
OPT9="-vf crop=${C9} -geometry ${G9}"
OPT10="-vf crop=${C10} -geometry ${G10}"
OPT11="-vf crop=${C11} -geometry ${G11}"
OPT12="-vf crop=${C12} -geometry ${G12}"

# make 9 fifo
mkfifo f1 f2 f3 f4 f5 f6 f7 f8 f9 f10 f11 f12

# row 1
#echo "mplayer ${MPOPTS} -slave -input file=f8 ${OPT8} ${VID0} &"
mplayer -slave -input file=f1 ${MPOPTS} ${OPT1} ${VID0} ${VID1} &
mplayer -slave -input file=f2 ${MPOPTS} ${OPT2} ${VID0} ${VID1} &
mplayer -slave -input file=f3 ${MPOPTS} ${OPT3} ${VID0} ${VID1} &
mplayer -slave -input file=f4 ${MPOPTS} ${OPT4} ${VID0} ${VID1} &
# row 2
mplayer -slave -input file=f5 ${MPOPTS} ${OPT5} ${VID0} ${VID1} &
mplayer -slave -input file=f6 ${MPOPTS} ${OPT6} ${VID0} ${VID1} &
mplayer -slave -input file=f7 ${MPOPTS} ${OPT7} ${VID0} ${VID1} &
mplayer -slave -input file=f8 ${MPOPTS} ${OPT8} ${VID0} ${VID1} &
# row 3
mplayer -slave -input file=f9 ${MPOPTS} ${OPT9} ${VID0} ${VID1} &
mplayer -slave -input file=f10 ${MPOPTS} ${OPT10} ${VID0} ${VID1} &
mplayer -slave -input file=f11 ${MPOPTS} ${OPT11} ${VID0} ${VID1} &
mplayer -slave -input file=f12 ${MPOPTS} ${OPT12} ${VID0} ${VID1} &
