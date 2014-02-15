#!/bin/ksh

if [ $# -lt 5 ]; then
    echo "Please Input ./mkuser.sh Pgroupname Groupname umask userid username"
    exit 1
fi

hostname=`hostname`
echo $hostname
echo "---------------------------------------"
lsgroup -a ALL | grep "^se$"
if [ $? -eq 0 ]; then
  echo `date +"%Y%m%d %H:%M:%S"` Groupname = se aleady exist
else
  echo `date +"%Y%m%d %H:%M:%S"` Groupname = se not exist, create new group
  mkgroup -a id=300 se
fi

lsgroup -a ALL | grep "^exc$"
if [ $? -eq 0 ]; then
  echo `date +"%Y%m%d %H:%M:%S"` Groupname = exc aleady exist
else
  echo `date +"%Y%m%d %H:%M:%S"` Groupname = exc not exist, create new group
  mkgroup -a id=600 exc 
fi

lsgroup -a ALL | grep "^tse$"
if [ $? -eq 0 ]; then
  echo `date +"%Y%m%d %H:%M:%S"` Groupname = tse aleady exist
else
  echo `date +"%Y%m%d %H:%M:%S"` Groupname = tse not exist, create new group
  mkgroup -a id=800 tse
fi
echo "---------------------------------------"


echo "---------------------------------------"
echo `date +"%Y%m%d %H:%M:%S"` "Check user...(/etc/passwd)"
grep "^$5:" /etc/passwd
execStatus=$?
if [ $execStatus -eq 0 ]; then
  echo
  echo `date +"%Y%m%d %H:%M:%S"` "user:$5 already exist"
  echo `date +"%Y%m%d %H:%M:%S"` "Change user:$5 attribute"
  if [ $5 == twse ]; then
     chuser pgrp=$1 groups=$2 home="/home/$1/$5" shell='/usr/bin/ksh' umask=$3 loginretries='10' pwdwarntime='7' histsize='6' maxexpired='1' maxage='12' minlen='7' $5
  else
     if [ $5 == useradm ]; then
        chuser pgrp=$1 groups=$2 home="/home/$1/$5" shell='/usr/bin/ksh' umask=$3 loginretries='10' pwdwarntime='7' histsize='6' maxexpired='1' maxage='12' minlen='7' $5
     else
        chuser pgrp=$1 groups=$2 home="/home/$1/$5" shell='/usr/bin/ksh' umask=$3 loginretries='10' pwdwarntime='7' histsize='6' maxexpired='1' maxage='7' minlen='7' $5
     fi
  fi 
else
  echo `date +"%Y%m%d %H:%M:%S"` "user:$5 not exist"
  echo `date +"%Y%m%d %H:%M:%S"` "Create new user:$5"
  if [ $5 == twse ]; then
     mkuser pgrp=$1 groups=$2 home="/home/$1/$5" shell='/usr/bin/ksh' umask=$3 id=$4 loginretries='10' pwdwarntime='7' histsize='6' maxexpired='1' maxage='12' minlen='7' $5
        echo "$5:1234567"|chpasswd
  else
     if [ $5 == useradm ]; then
        mkuser pgrp=$1 groups=$2 home="/home/$1/$5" shell='/usr/bin/ksh' umask=$3 id=$4 loginretries='10' pwdwarntime='7' histsize='6' maxexpired='1' maxage='12' minlen='7' $5
        echo "$5:1234567"|chpasswd
        pwdadm -c $5
     else
        mkuser pgrp=$1 groups=$2 home="/home/$1/$5" shell='/usr/bin/ksh' umask=$3 id=$4 loginretries='10' pwdwarntime='7' histsize='6' maxexpired='1' maxage='7' minlen='7' $5
        echo "$5:1234567"|chpasswd
        pwdadm -c $5
     fi
  fi
fi
echo "---------------------------------------"

exit
