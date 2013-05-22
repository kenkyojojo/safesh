#! /usr/bin/ksh
#
stty -echo
print -n Enter Old Password-
read OLDPASS
print 
print -n Enter New Password-
read NEWPASS
print
stty echo
USER=$(whoami)
exec 4>&1

/home/se/safechk/safesh/pwchg_expect_telnet.sh $USER $OLDPASS $NEWPASS

exit 0
