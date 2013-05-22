#!/bin/ksh

hostname=`hostname`
BINDIR=/home/se/safechk/safesh/
LOGDIR=/home/se/safechk/selog/chg

$BINDIR/filechg.sh > $LOGDIR/`date +%Y%m%d`_fileattr.txt 2> $LOGDIR/`date +%Y%m%d`_fileattr.err
chown useradm:security $LOGDIR/*

exit
