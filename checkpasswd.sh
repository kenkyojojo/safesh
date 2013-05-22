#!/usr/bin/ksh
# next_pwch
# display date of next passwd change

#----------------------------------
# Set variable
#----------------------------------
# maxage value is in number of weeks
# secs in a day is:86400 ..so
secs_in_week=604800
hostname=`hostname`
timestamp=`date +"%Y%m%d%H%M%S"`
log=/home/se/safechk/safelog/chpasswd.${hostname}.pwchange.$timestamp.txt >> $log
list=$(lsuser -a registry ALL|grep -w files| awk '{print $1}')


#----------------------------------
# Main function
#----------------------------------
echo "Date: $timestamp" >>$log
echo "Local Password Expiry $hostname">>$log
echo "user  change           last change                    next change">>$log
echo "       weeks           password                        password">>$log

for user in $list
do
	wks_before_ch=$(lsuser -a maxage $user | awk -F '=' '{print $2}')
	if [ "$wks_before_ch" = "" ]
  	then
   		# krb5 / ldap /limbo"
   		expire="??"
  	else
   		expire=$wks_before_ch
 	fi
 
	last_ch_pw=$(pwdadm -q $user | grep last | awk '{print $3}')

	# echo "last pw change : $last_ch_pw"
	if [ "$last_ch_pw" = "" ]
   	then
    	passset="password never set"
	else
		last_ch_pw_conv=$(perl -e 'print localtime('$last_ch_pw')."\n";')
 		last_pw_ch=$last_ch_pw_conv
 		passset=$last_pw_ch
		total_secs=$(expr $secs_in_week \* $wks_before_ch)
		#echo "total secs: $total_secs"
		# weeks + last pw change
		date_to_ch=`expr $total_secs + $last_ch_pw`
 
		#pw_flags=$(pwdadm -q $user | grep flags | awk '{print $3}')
 		#pw_flags=$pw_flags
 
		# now convert to normal
		next_pw_ch=$(perl -e 'print localtime('$date_to_ch')."\n";')
	fi
 
	#echo "..$user..$wks_before_ch..$passset"
  	if [ "$wks_before_ch" = "0" ]
  	then
  		next_pw_ch=""
 	else
  		next_pw_ch=$next_pw_ch
	fi
 
	if [ "$passset" = "password never set" ]
 	then
  		#echo "..$user.."
    	next_pw_ch=""
 	fi

	printf "%-8s %-7s %-30s %-10s%-28s\n" "$user" "$expire" "$passset" "$next_pw_ch" >>$log 
done
