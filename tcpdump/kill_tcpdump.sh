#!/bin/ksh

DATAPATH="/home/se/safechk/safesh/tcpdump"
#DATAPATH="/TWSE/MIS/SE/tcpdump

set -e
ps -U root -f | grep "tcpdump -w" > $DATAPATH/backproc.txt
backproc=`awk '{FS=" ";printf $2"\n"}' $DATAPATH/backproc.txt`
 for i in $backproc
  do
     kill -9 $i
  done
rm $DATAPATH/backproc.txt

