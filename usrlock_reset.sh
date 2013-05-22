#! /usr/bin/ksh
#
#----------------------------------
# Set variable
#----------------------------------
lockusers=`lsuser -a account_locked ALL | grep "false" | awk '{print $1}'`
skip_users="[ isso sa so daemon bin sys adm uucp guest nobody lpd lp snapp ipsec nuucp pconsole invscout esaadmin sshd ]"


#----------------------------------
# unlock user lock status
#----------------------------------
for user1 in $lockusers
do
   finduserx=`echo $skip_users | grep " $user1 "`
   if [ ! -n "$finduserx" ]; then
       chsec -f /etc/security/lastlog -a unsuccessful_login_count=0 -s ${user1}
       chuser account_locked=false ${user1}
       pwdadm -c ${user1}
   fi
done

exit
