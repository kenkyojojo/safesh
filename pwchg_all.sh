#! /usr/bin/ksh
#
stty -echo
print -n Enter Old Password-
read OLDPASS
print 
print -n Enter New Password-
read NEWPASS
print
print -n Enter New Password again-
read NEWPASS1
print
stty echo
USER=$(whoami)
exec 4>&1

if [ "$NEWPASS" == "$NEWPASS1" ]; then
   /home/se/safechk/safesh/pwchg_expect.sh $USER $OLDPASS $NEWPASS
else
   echo
   echo Date: `date +%Y/%m/%d\ %H:%M:%S` 'New Password does not match the confirm password'
fi

exit 0
