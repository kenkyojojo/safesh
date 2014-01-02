#!/usr/bin/ksh 
IOS=/usr/ios/cli/ioscli

#vfchost0:FIXGWO1B mapping fcs0
$IOS vfcmap -vadapter vfchost0 -fcp fcs0 

#vfchost1:FIXGWO2P mapping fcs2
$IOS vfcmap -vadapter vfchost1 -fcp fcs2

###############################################
#vfchost2:TS2 mapping fcs4
#vfchost3:WKLPAR mapping fcs4
#vfchost4:MDS2 mapping fcs4
#vfchost5:LOG2 mapping fcs4
#vfchost6~7:DAR2-1 ~ DAR2-2 mapping fcs4
#vfchost8~27:DAP2-1 ~ DAR2-20 mapping fcs4
###############################################
n=2
while [[ $n -le 27 ]]
do
	$IOS vfcmap -vadapter vfchost${n} -fcp fcs4
	(( n=$n+1 ))
done
