#!/bin/ksh

CHECKSUM=/home/se/safechk/safesh/dailycheck/checksum
CHECKSUMLOG=/home/se/safechk/safelog

$CHECKSUM/checksum.sh > $CHECKSUMLOG/`date +%Y%m%d_chksum_attr.rpt` 2> $CHECKSUM/err/`date +%Y%m%d_chksum_attr.err`
cat $CHECKSUMLOG/`date +%Y%m%d_chksum_attr.rpt`
