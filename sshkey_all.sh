#! /usr/bin/ksh
#

if [ $# -lt 1 ]; then
    echo "Please Input sshkey_all.sh username"
    echo
    echo "Example: sshkey_all.sh se01"
    exit 1
fi

#----------------------------------
# Set variable
#----------------------------------
WLPAR=`hostname`
USERLIST=$1

stty -echo
print -n Enter $USERLIST Password-
read PASSWORD
print
print -n Enter $USERLIST Password again-
read PASSWORD1
print
stty echo
exec 4>&1

if [ -z "$PASSWORD" ]; then
    echo ""
    echo "               [Error]  �K�X��J���ŭ� "
    exit
fi

if [ "$PASSWORD" == "$PASSWORD1" ]; then
   #----------------------------------
   # ssh keygen
   #----------------------------------
   for USER in $USERLIST ; do
      HOMEDIR=`lsuser $USER | awk '{print $5}' | cut -c6-`
      SSHDIR="$HOMEDIR/.ssh"
      /home/se/safechk/safesh/sshkeygen_expect.sh $USER $PASSWORD $SSHDIR $WLPAR
   done

   #----------------------------------
   # ssh key insert into authorized_key file
   #----------------------------------
   for USER in $USERLIST ; do
      HOMEDIR=`lsuser $USER | awk '{print $5}' | cut -c6-`
      GROUP=`lsuser $USER | awk '{print $3}' | cut -c6-`
      SSHDIR="$HOMEDIR/.ssh"
      cd $SSHDIR
      cat /dev/null > authorized_keys
      #cat id_rsa.pub >> authorized_keys
      cat id_rsa.pub.*.${USER} >> authorized_keys
      chmod 600 authorized_keys
      chown ${USER}:${GROUP} authorized_keys
      rm id_rsa.pub.*.${USER}
   done

   #----------------------------------
   # sync authorized_key file
   #----------------------------------
   for USER in $USERLIST ; do
      HOMEDIR=`lsuser $USER | awk '{print $5}' | cut -c6-`
      SSHDIR="$HOMEDIR/.ssh"
      /home/se/safechk/safesh/sshkeysync_expect.sh $USER $PASSWORD $SSHDIR
   done
   exit
else
   echo
   echo Date: `date +%Y/%m/%d\ %H:%M:%S` 'New Password does not match the confirm password'
fi

exit 0
