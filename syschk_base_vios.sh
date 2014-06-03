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
echo "#================= 主機名稱資訊 ================#" >> $LOGFILE
hostname >> $LOGFILE
echo "#===== 確認上述資訊是否正確? Yes( ) NO( ) ======#" >> $LOGFILE 
echo "" >> $LOGFILE
}
#}}}

#{{{oslevel_info
oslevel_info() {
echo "" >> $LOGFILE
echo "#================= 作業系統版本 ================#" >> $LOGFILE
ioslevel >> $LOGFILE
echo "#===== 確認上述資訊是否正確? Yes( ) NO( ) ======#" >> $LOGFILE
echo "" >> $LOGFILE
}
#}}}

#{{{java_info
java_info () {
echo "" >> $LOGFILE
echo "#================= Java版本 ====================#" >> $LOGFILE
lslpp -l | grep Java | grep -v idebug | awk '{printf "%-25s %-10s\n", $1,$2}' >> $LOGFILE
echo "#===== 確認上述資訊是否正確? Yes( ) NO( ) ======#" >> $LOGFILE
echo "" >> $LOGFILE
}
#}}}

#{{{mem_info
mem_info () {
echo "" >> $LOGFILE
echo "#================= Memory 資訊 =================#" >> $LOGFILE
prtconf -m >> $LOGFILE
echo "#===== 確認上述資訊是否正確? Yes( ) NO( ) ======#" >> $LOGFILE
echo "" >> $LOGFILE
}
#}}}

#{{{page_info
page_info(){
echo "" >> $LOGFILE
echo "#================= Page 資訊 ===================#" >> $LOGFILE
lsps -a >> $LOGFILE
echo "#===== 確認上述資訊是否正確? Yes( ) NO( ) ======#" >> $LOGFILE
echo "" >> $LOGFILE
}
#}}}

#{{{network_info
network_info (){
echo "" >> $LOGFILE
echo "#================= 網路裝置 ====================#" >> $LOGFILE
lscfg  | grep ^ent >> $LOGFILE
echo "#===== 確認上述資訊是否正確? Yes( ) NO( ) ======#" >> $LOGFILE
echo "" >> $LOGFILE
}
#}}}

#{{{fcs_info
fcs_info () {
echo "" >> $LOGFILE
echo "#================= 光纖裝置 ====================#" >> $LOGFILE
lscfg  | grep ^fcs >> $LOGFILE
echo "#===== 確認上述資訊是否正確? Yes( ) NO( ) ======#" >> $LOGFILE
echo "" >> $LOGFILE
}
#}}}

#{{{disk_info
disk_info () {
echo "" >> $LOGFILE
echo "#================= 磁碟路徑 ====================#" >> $LOGFILE
lspath >> $LOGFILE
echo "Total Disk path: `lspath|wc -l|awk '{print $1}'`" >> $logfile 
echo "#===== 確認上述資訊是否正確? Yes( ) NO( ) ======#" >> $LOGFILE
echo "" >> $LOGFILE
}
#}}}

#{{{network_address_info
network_address_info () {
echo "" >> $LOGFILE
echo "#================= 網路位址 ====================#" >> $LOGFILE
ifconfig -a | grep "inet " | grep -v "127.0.0.1" | awk '{print $2}' >> $LOGFILE
echo "#===== 確認上述資訊是否正確? Yes( ) NO( ) ======#" >> $LOGFILE
echo "" >> $LOGFILE
}
#}}}

#{{{route_info
route_info() {
echo "" >> $LOGFILE
echo "#================= 路由資訊 ====================#" >> $LOGFILE
netstat -rn | grep -E 'en|lo' | awk '{print $1 "\t" $2}'  | grep -v '::1%1' >> $LOGFILE
echo "#===== 確認上述資訊是否正確? Yes( ) NO( ) ======#" >> $LOGFILE
echo "" >> $LOGFILE
}
#}}}

#{{{filesystem_info
filesystem_info() {
echo "" >> $LOGFILE
echo "#================= 檔案系統 ====================#" >> $LOGFILE
df -gP | grep -Ev '/proc|livedump' | awk '{print $2, "\t" $6}' >> $LOGFILE
echo "#===== 確認上述資訊是否正確? Yes( ) NO( ) ======#" >> $LOGFILE
echo "" >> $LOGFILE
}
#}}}

#{{{lvm_info
lvm_info() {
echo "" >> $LOGFILE
echo "#================= Mirror狀態 ==================#" >> $LOGFILE
VGNAME=`lsvg`
for vgname in $VGNAME
do
  lsvg -l $vgname >> $LOGFILE
done
echo "#===== 確認上述資訊是否正確? Yes( ) NO( ) ======#" >> $LOGFILE
echo "" >> $LOGFILE
}
#}}}}

#{{{boot_info
boot_info() {
echo "" >> $LOGFILE
echo "#================= 開機順序 ====================#" >> $LOGFILE
bootlist -m normal -o >> $LOGFILE
echo "#===== 確認上述資訊是否正確? Yes( ) NO( ) ======#" >> $LOGFILE
echo "" >> $LOGFILE
}
#}}}

#{{{itm_info
itm_info() {
echo "" >> $LOGFILE
echo "#================= ITM agent狀態 ===============#" >> $LOGFILE
/opt/IBM/ITM/bin/cinfo -r | grep "^`hostname`" | awk '{print $1, $2, $4, $7}' >> $LOGFILE
echo "#===== 確認上述資訊是否正確? Yes( ) NO( ) ======#" >> $LOGFILE
echo "" >> $LOGFILE
}
#}}}

#{{{ctm_info
ctm_info() {
echo "" >> $LOGFILE
echo "#================= CTM agent狀態 ===============#" >> $LOGFILE
su - twse "shagent" | grep ^twse | grep -v "Password" | awk '{print $1, "\t",$NF}'  >> $LOGFILE
echo "#===== 確認上述資訊是否正確? Yes( ) NO( ) ======#" >> $LOGFILE
echo "" >> $LOGFILE
}
#}}}

#{{{user_limit_info
user_limit_info() {
echo "" >> $LOGFILE
echo "#================= 使用者限制 ==================#" >> $LOGFILE
ulimit -a >> $LOGFILE
echo "#===== 確認上述資訊是否正確? Yes( ) NO( ) ======#" >> $LOGFILE
echo "" >> $LOGFILE
}
#}}}

#{{{user_info
user_info() {
echo "" >> $LOGFILE
echo "#============== 使用者帳號與群組================#" >> $LOGFILE
echo "帳號" >> $LOGFILE
lsuser ALL | awk '{printf "%-10s %-15s %-15s %-45s %-10s\n", $1,$2,$3,$4,$5}' >> $LOGFILE
echo "群組" >> $LOGFILE
lsgroup ALL | awk '{printf "%-10s %-15s %-15s %-10s\n", $1,$2,$3,$4}' >> $LOGFILE
echo "#===== 確認上述資訊是否正確? Yes( ) NO( ) ======#" >> $LOGFILE
echo "" >> $LOGFILE
}
#}}}

#{{{cus_user_info
cus_user_info() {
echo "" >> $LOGFILE
echo "#================ 帳號管控資訊 =================#" >> $LOGFILE
#USERLIST="root seadm se01 se02 exadm ex11 ex14 ex16 twse useradm"
USERLIST=`cat /home/se/safechk/file/account/user.lst`
for USER in $USERLIST
do
  lsuser $USER | awk '{printf "%-10s %-18s %-20s %-15s %-20s %-18s %-15s\n", $1,$23,$24,$27,$28,$37,$39}' >> $LOGFILE
done
echo "#===== 確認上述資訊是否正確? Yes( ) NO( ) ======#" >> $LOGFILE
echo "" >> $LOGFILE
}
#}}}

#{{{no_info
no_info () {
echo "" >> $LOGFILE
echo "#================ 系統網路參數 =================#" >> $LOGFILE
no -a >> $LOGFILE
echo "#===== 確認上述資訊是否正確? Yes( ) NO( ) ======#" >> $LOGFILE
echo "" >> $LOGFILE
}
#}}}

#{{{vmo_info
vmo_info() {
echo "" >> $LOGFILE
echo "#================ 系統記憶體參數 =================#" >> $LOGFILE
vmo -a | grep -Ev 'pinnable_frames|maxpin|maxperm|minperm'>> $LOGFILE
echo "#===== 確認上述資訊是否正確? Yes( ) NO( ) ======#" >> $LOGFILE
echo "" >> $LOGFILE
}
#}}}

#{{{vfc_mapping_info
vfc_mapping_info() {
echo "" >> $LOGFILE
echo "#================ 光纖對映關係=================#" >> $LOGFILE
$IOS lsmapp -all -npiv >> $LOGFILE
echo "#===== 確認上述資訊是否正確? Yes( ) NO( ) ======#" >> $LOGFILE
echo "" >> $LOGFILE
}
#}}}

#{{{sea_network_mapping_info
sea_network_mapping_info() {
echo "" >> $LOGFILE
echo "#================ 網路對映關係=================#" >> $LOGFILE

for dev in  `lscfg | grep ^ent | awk '{print $1}'`
do
	$IOS lsmap -vadapter $dev -fmt ":" >> $LOGFILE
	$IOS lsmap -vadapter $dev -net  >> $LOGFILE
done

for dev in  ${ent_dev[@]}
do
	entstat -d $dev | egrep -i "media | link | synch | aggre | ethernet"  >> $LOGFILE
done

echo "#===== 確認上述資訊是否正確? Yes( ) NO( ) ======#" >> $LOGFILE
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
