#!/bin/ksh

DATAPATH="/home/se/safechk/safesh/tcpdump"
#DATAPATH="/TWSE/MIS/SE/tcpdump"

set -e

cd $DATAPATH
ls *.pcap > $DATAPATH/file.txt
ls *.pcap.old > $DATAPATH/fileold.txt

while read oldname
do
  rm $oldname
done < $DATAPATH/fileold.txt

while read name
do
  mv ${name} ${name}.old
done < $DATAPATH/file.txt

ifconfig -a | grep en > $DATAPATH/backif1.txt
backif1=`awk '$0~/en[0-9]/{FS=": ";printf $1"\n"}' $DATAPATH/backif1.txt`
echo $backif1
 for i in $backif1;
  do
  tcpdump -w $DATAPATH/p$i.pcap -v -i $i -s 0& 
  done
ps -ef |grep tcpdump

rm $DATAPATH/backif1.txt
rm $DATAPATH/file.txt
rm $DATAPATH/fileold.txt

