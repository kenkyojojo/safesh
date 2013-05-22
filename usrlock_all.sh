#! /usr/bin/ksh
#

if [ $# -lt 1 ]; then
    echo "Please Input usrlock_all.sh username"
    echo
    echo "Example: usrlock_all.sh se01"
    exit 1
fi

USER=$(whoami)
USERNAME=$1

stty -echo
print -n Enter $USER Password-
read USERPASS
print
print -n Enter $USER Password again-
read USERPASS1
print
stty echo
USER=$(whoami)
exec 4>&1

if [ -z "$USERPASS" ]; then
    echo ""
    echo "               [Error]  ±K½X¿é¤J¬°ªÅ­È "
    exit
fi

if [ "$USERPASS" == "$USERPASS1" ]; then
   /home/se/safechk/safesh/usrlock_expect_ssh.sh $USERNAME $USER $USERPASS
else
   echo
   echo Date: `date +%Y/%m/%d\ %H:%M:%S` 'New Password does not match the confirm password'
fi

exit 0
