#!/bin/ksh
#
#----------------------------------
# Set variable
#----------------------------------
IPSECFILE=/home/se/safechk/cfg/ipsec_fltr_rule.exp
RULENUM=3
IPLIST=`cat /home/se/safechk/cfg/ip.lst`
PERMIT4=`cat /home/se/safechk/cfg/permit4.lst`
DENYPORT="20 21 22 2222 23"
PERMITPORT="2222"
IPADDR=""

cat /dev/null > $IPSECFILE

#----------------------------------
# permit working LPAR ip and port
#----------------------------------
for IPADDR in $PERMIT4 ; do
   for PPORT in $PERMITPORT ; do
      echo "4 $RULENUM permit 10.199.168.154 255.255.255.255 $IPADDR 255.255.255.255 y all any 0 eq  $PPORT all both  both     no yes 0 no 0 patt_none " >> $IPSECFILE
      let RULENUM=$RULENUM+1
   done
done

#----------------------------------
# deny all connection from denyport
#----------------------------------
for IPADDR in $IPLIST ; do
   for DPORT in $DENYPORT ; do
      echo "4 $RULENUM deny 0.0.0.0 0.0.0.0 $IPADDR 255.255.255.255 y all any 0 eq  $DPORT all both  both     no yes 0 no 0 patt_none " >> $IPSECFILE
      let RULENUM=$RULENUM+1
   done
done

