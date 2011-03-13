#!/bin/bash

# Videos
VID0=http://localhost:8080/stream
VID1=http://localhost:8082/stream
#VID0=${HOME}/Desktop/google.mp4
#VID1=${HOME}/Desktop/nexus.mp4

# Common MPlayer commands
MPOPTS="-noborder -nocache -nosound "

# Basic values
XOFF=0 # offset
YOFF=152
W0=427
W1=426
H=240

let X0=0
let X1=${W0}
let X2=${W0}+${W1}
let Y0=0
let Y1=${H}
let Y2=${H}*2
let XX0=${X0}+${XOFF}
let XX1=${X1}+${XOFF}
let XX2=${X2}+${XOFF}
let YY0=${Y0}+${YOFF}
let YY1=${Y1}+${YOFF}
let YY2=${Y2}+${YOFF}

# row 1
C1="${W0}:${H}:${X0}:${Y0}"
C2="${W1}:${H}:${X1}:${Y0}"
C3="${W0}:${H}:${X2}:${Y0}"
# row 2
C4="${W0}:${H}:${X0}:${Y1}"
C5="${W1}:${H}:${X1}:${Y1}"
C6="${W0}:${H}:${X2}:${Y1}"
# row 3
C7="${W0}:${H}:${X0}:${Y2}"
C8="${W1}:${H}:${X1}:${Y2}"
C9="${W0}:${H}:${X2}:${Y2}"

# row 1
G1="${XX0}:${YY0}"
G2="${XX1}:${YY0}"
G3="${XX2}:${YY0}"
# row 2
G4="${XX0}:${YY1}"
G5="${XX1}:${YY1}"
G6="${XX2}:${YY1}"
# row 3
G7="${XX0}:${YY2}"
G8="${XX1}:${YY2}"
G9="${XX2}:${YY2}"

# row 1
OPT1="-vf crop=${C1} -geometry ${G1}"
OPT2="-vf crop=${C2} -geometry ${G2}"
OPT3="-vf crop=${C3} -geometry ${G3}"
# row 2
OPT4="-vf crop=${C4} -geometry ${G4}"
OPT5="-vf crop=${C5} -geometry ${G5}"
OPT6="-vf crop=${C6} -geometry ${G6}"
# row 3
OPT7="-vf crop=${C7} -geometry ${G7}"
OPT8="-vf crop=${C8} -geometry ${G8}"
OPT9="-vf crop=${C9} -geometry ${G9}"

# make 9 fifo
mkfifo f1 f2 f3 f4 f5 f6 f7 f8 f9

# row 1
#echo "mplayer ${MPOPTS} -slave -input file=f8 ${OPT8} ${VID0} &"
mplayer -slave -input file=f1 ${MPOPTS} ${OPT1} ${VID1} ${VID0} &
mplayer -slave -input file=f2 ${MPOPTS} ${OPT2} ${VID0} ${VID1} &
mplayer -slave -input file=f3 ${MPOPTS} ${OPT3} ${VID1} ${VID0} &
# row 2
mplayer -slave -input file=f4 ${MPOPTS} ${OPT4} ${VID0} ${VID1} &
mplayer -slave -input file=f5 ${MPOPTS} ${OPT5} ${VID1} ${VID0} &
mplayer -slave -input file=f6 ${MPOPTS} ${OPT6} ${VID0} ${VID1} &
# row 3
mplayer -slave -input file=f7 ${MPOPTS} ${OPT7} ${VID1} ${VID0} &
mplayer -slave -input file=f8 ${MPOPTS} ${OPT8} ${VID0} ${VID1} &
mplayer -slave -input file=f9 ${MPOPTS} ${OPT9} ${VID1} ${VID0} &
