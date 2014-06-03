#!/bin/ksh
LOGDIR=/home/padmin/file/syschk/base
LOGFILE=$LOGDIR/syschk.`hostname`.base
BKLOGFILE=$LOGDIR/syschk.`hostname`.base.`date +%Y%m%d`
IOS=/usr/ios/cli/ioscli
set -A ent_dev ent41 ent42 ent43 ent44 ent45 ent46 ent47 ent48 ent49 ent50 ent51 ent52 ent53
#######################################################

#{{{hostname_info
hostname_info () {
echo "" > $LOGFILE
echo "#================= �D���W�ٸ�T ================#" >> $LOGFILE
hostname >> $LOGFILE
echo "#===== �T�{�W�z��T�O�_���T? Yes( ) NO( ) ======#" >> $LOGFILE 
echo "" >> $LOGFILE
}
#}}}

#{{{oslevel_info
oslevel_info() {
echo "" >> $LOGFILE
echo "#================= �@�~�t�Ϊ��� ================#" >> $LOGFILE
ioslevel >> $LOGFILE
echo "#===== �T�{�W�z��T�O�_���T? Yes( ) NO( ) ======#" >> $LOGFILE
echo "" >> $LOGFILE
}
#}}}

#{{{java_info
java_info () {
echo "" >> $LOGFILE
echo "#================= Java���� ====================#" >> $LOGFILE
lslpp -l | grep Java | grep -v idebug | awk '{printf "%-25s %-10s\n", $1,$2}' >> $LOGFILE
echo "#===== �T�{�W�z��T�O�_���T? Yes( ) NO( ) ======#" >> $LOGFILE
echo "" >> $LOGFILE
}
#}}}

#{{{mem_info
mem_info () {
echo "" >> $LOGFILE
echo "#================= Memory ��T =================#" >> $LOGFILE
prtconf -m >> $LOGFILE
echo "#===== �T�{�W�z��T�O�_���T? Yes( ) NO( ) ======#" >> $LOGFILE
echo "" >> $LOGFILE
}
#}}}

#{{{page_info
page_info(){
echo "" >> $LOGFILE
echo "#================= Page ��T ===================#" >> $LOGFILE
lsps -a >> $LOGFILE
echo "#===== �T�{�W�z��T�O�_���T? Yes( ) NO( ) ======#" >> $LOGFILE
echo "" >> $LOGFILE
}
#}}}

#{{{network_info
network_info (){
echo "" >> $LOGFILE
echo "#================= �����˸m ====================#" >> $LOGFILE
lscfg  | grep ^ent >> $LOGFILE
echo "#===== �T�{�W�z��T�O�_���T? Yes( ) NO( ) ======#" >> $LOGFILE
echo "" >> $LOGFILE
}
#}}}

#{{{fcs_info
fcs_info () {
echo "" >> $LOGFILE
echo "#================= ���ָ˸m ====================#" >> $LOGFILE
lscfg  | grep ^fcs >> $LOGFILE
echo "#===== �T�{�W�z��T�O�_���T? Yes( ) NO( ) ======#" >> $LOGFILE
echo "" >> $LOGFILE
}
#}}}

#{{{disk_info
disk_info () {
echo "" >> $LOGFILE
echo "#================= �Ϻи��| ====================#" >> $LOGFILE
lspath >> $LOGFILE
echo "Total Disk path: `lspath|wc -l|awk '{print $1}'`" >> $logfile 
echo "#===== �T�{�W�z��T�O�_���T? Yes( ) NO( ) ======#" >> $LOGFILE
echo "" >> $LOGFILE
}
#}}}

#{{{network_address_info
network_address_info () {
echo "" >> $LOGFILE
echo "#================= ������} ====================#" >> $LOGFILE
ifconfig -a | grep "inet " | grep -v "127.0.0.1" | awk '{print $2}' >> $LOGFILE
echo "#===== �T�{�W�z��T�O�_���T? Yes( ) NO( ) ======#" >> $LOGFILE
echo "" >> $LOGFILE
}
#}}}

#{{{route_info
route_info() {
echo "" >> $LOGFILE
echo "#================= ���Ѹ�T ====================#" >> $LOGFILE
netstat -rn | grep -E 'en|lo' | awk '{print $1 "\t" $2}'  | grep -v '::1%1' >> $LOGFILE
echo "#===== �T�{�W�z��T�O�_���T? Yes( ) NO( ) ======#" >> $LOGFILE
echo "" >> $LOGFILE
}
#}}}

#{{{filesystem_info
filesystem_info() {
echo "" >> $LOGFILE
echo "#================= �ɮרt�� ====================#" >> $LOGFILE
df -gP | grep -Ev '/proc|livedump' | awk '{print $2, "\t" $6}' >> $LOGFILE
echo "#===== �T�{�W�z��T�O�_���T? Yes( ) NO( ) ======#" >> $LOGFILE
echo "" >> $LOGFILE
}
#}}}

#{{{lvm_info
lvm_info() {
echo "" >> $LOGFILE
echo "#================= Mirror���A ==================#" >> $LOGFILE
VGNAME=`lsvg`
for vgname in $VGNAME
do
  lsvg -l $vgname >> $LOGFILE
done
echo "#===== �T�{�W�z��T�O�_���T? Yes( ) NO( ) ======#" >> $LOGFILE
echo "" >> $LOGFILE
}
#}}}}

#{{{boot_info
boot_info() {
echo "" >> $LOGFILE
echo "#================= �}������ ====================#" >> $LOGFILE
bootlist -m normal -o >> $LOGFILE
echo "#===== �T�{�W�z��T�O�_���T? Yes( ) NO( ) ======#" >> $LOGFILE
echo "" >> $LOGFILE
}
#}}}

#{{{itm_info
itm_info() {
echo "" >> $LOGFILE
echo "#================= ITM agent���A ===============#" >> $LOGFILE
/opt/IBM/ITM/bin/cinfo -r | grep "^`hostname`" | awk '{print $1, $2, $4, $7}' >> $LOGFILE
echo "#===== �T�{�W�z��T�O�_���T? Yes( ) NO( ) ======#" >> $LOGFILE
echo "" >> $LOGFILE
}
#}}}

#{{{ctm_info
ctm_info() {
echo "" >> $LOGFILE
echo "#================= CTM agent���A ===============#" >> $LOGFILE
su - twse "shagent" | grep ^twse | grep -v "Password" | awk '{print $1, "\t",$NF}'  >> $LOGFILE
echo "#===== �T�{�W�z��T�O�_���T? Yes( ) NO( ) ======#" >> $LOGFILE
echo "" >> $LOGFILE
}
#}}}

#{{{user_limit_info
user_limit_info() {
echo "" >> $LOGFILE
echo "#================= �ϥΪ̭��� ==================#" >> $LOGFILE
ulimit -a >> $LOGFILE
echo "#===== �T�{�W�z��T�O�_���T? Yes( ) NO( ) ======#" >> $LOGFILE
echo "" >> $LOGFILE
}
#}}}

#{{{user_info
user_info() {
echo "" >> $LOGFILE
echo "#============== �ϥΪ̱b���P�s��================#" >> $LOGFILE
echo "�b��" >> $LOGFILE
lsuser ALL | awk '{printf "%-10s %-15s %-15s %-45s %-10s\n", $1,$2,$3,$4,$5}' >> $LOGFILE
echo "�s��" >> $LOGFILE
lsgroup ALL | awk '{printf "%-10s %-15s %-15s %-10s\n", $1,$2,$3,$4}' >> $LOGFILE
echo "#===== �T�{�W�z��T�O�_���T? Yes( ) NO( ) ======#" >> $LOGFILE
echo "" >> $LOGFILE
}
#}}}

#{{{cus_user_info
cus_user_info() {
echo "" >> $LOGFILE
echo "#================ �b���ޱ���T =================#" >> $LOGFILE
#USERLIST="root seadm se01 se02 exadm ex11 ex14 ex16 twse useradm"
USERLIST=`cat /home/se/safechk/file/account/user.lst`
for USER in $USERLIST
do
  lsuser $USER | awk '{printf "%-10s %-18s %-20s %-15s %-20s %-18s %-15s\n", $1,$23,$24,$27,$28,$37,$39}' >> $LOGFILE
done
echo "#===== �T�{�W�z��T�O�_���T? Yes( ) NO( ) ======#" >> $LOGFILE
echo "" >> $LOGFILE
}
#}}}

#{{{no_info
no_info () {
echo "" >> $LOGFILE
echo "#================ �t�κ����Ѽ� =================#" >> $LOGFILE
no -a >> $LOGFILE
echo "#===== �T�{�W�z��T�O�_���T? Yes( ) NO( ) ======#" >> $LOGFILE
echo "" >> $LOGFILE
}
#}}}

#{{{vmo_info
vmo_info() {
echo "" >> $LOGFILE
echo "#================ �t�ΰO����Ѽ� =================#" >> $LOGFILE
vmo -a | grep -Ev 'pinnable_frames|maxpin|maxperm|minperm'>> $LOGFILE
echo "#===== �T�{�W�z��T�O�_���T? Yes( ) NO( ) ======#" >> $LOGFILE
echo "" >> $LOGFILE
}
#}}}

#{{{vfc_mapping_info
vfc_mapping_info() {
echo "" >> $LOGFILE
echo "#================ ���ֹ�M���Y=================#" >> $LOGFILE
$IOS lsmapp -all -npiv >> $LOGFILE
echo "#===== �T�{�W�z��T�O�_���T? Yes( ) NO( ) ======#" >> $LOGFILE
echo "" >> $LOGFILE
}
#}}}

#{{{sea_network_mapping_info
sea_network_mapping_info() {
echo "" >> $LOGFILE
echo "#================ ������M���Y=================#" >> $LOGFILE

for dev in  `lscfg | grep ^ent | awk '{print $1}'`
do
	$IOS lsmap -vadapter $dev -fmt ":" >> $LOGFILE
	$IOS lsmap -vadapter $dev -net  >> $LOGFILE
done

for dev in  ${ent_dev[@]}
do
	entstat -d $dev | egrep -i "media | link | synch | aggre | ethernet"  >> $LOGFILE
done

echo "#===== �T�{�W�z��T�O�_���T? Yes( ) NO( ) ======#" >> $LOGFILE
echo "" >> $LOGFILE
}
#}}}

#{{{main
main () {

	if [[ -d $LOGDIR  ]] ;then
		mkdir -p $LOGDIR
	fi

	# vios check info

	#:1  check hostname information
	echo "#=01=#" >> $LOGFILE
	hostname_info

	#:2 check os information
	echo "#=02=#" >> $LOGFILE
	oslevel_info

	#:3 check pageing sapce information
	echo "#=03=#" >> $LOGFILE
	page_info

	#:4 step 4 check network device information
	echo "#=04=#" >> $LOGFILE
	network_info

	#:5 check Fibre Channel information
	echo "#=05=#" >> $LOGFILE
	fcs_info

	#:6 check disk information
	echo "#=06=#" >> $LOGFILE
	disk_info

	#:7 check network information
	echo "#=07=#" >> $LOGFILE
	network_address_info

	#:8 check route information
	echo "#=08=#" >> $LOGFILE
	route_info

	#:9 check filesystem information
	echo "#=09=#" >> $LOGFILE
	filesystem_info

	#:10 check Logic Volume information
	echo "#=10=#" >> $LOGFILE
	lvm_info

	#:11 scheck hostname information
	echo "#=11=#" >> $LOGFILE
	boot_info

	#:12 check ITM information
	echo "#=12=#" >> $LOGFILE
	itm_info

	#:13 check user limite information
	echo "#=13=#" >> $LOGFILE
	user_limit_info

	#:14 check user information
	echo "#=14=#" >> $LOGFILE
	user_info

	#:15 check Fibre Channel mapping information
	echo "#=15=#" >> $LOGFILE
	vfc_mapping_info

	#:16 check sea network mapping information
	echo "#=16=#" >> $LOGFILE
	sea_network_mapping_info

	# Backup base file
	cp $LOGFILE $BKLOGFILE 
}
#}}}

main
