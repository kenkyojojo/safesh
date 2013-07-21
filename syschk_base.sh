#!/bin/ksh
LOGDIR=/home/se/safechk/file/syschk/base
LOGFILE=$LOGDIR/syschk.`hostname`.base
BKLOGFILE=$LOGDIR/syschk.`hostname`.base.`date +%Y%m%d`
#######################################################

echo "" > $LOGFILE
echo "#================= 主機名稱資訊 ================#" >> $LOGFILE
hostname >> $LOGFILE
echo "#===== 確認上述資訊是否正確? Yes( ) NO( ) ======#" >> $LOGFILE 
echo "" >> $LOGFILE

echo "" >> $LOGFILE
echo "#================= 作業系統版本 ================#" >> $LOGFILE
oslevel -s >> $LOGFILE
echo "#===== 確認上述資訊是否正確? Yes( ) NO( ) ======#" >> $LOGFILE
echo "" >> $LOGFILE

echo "" >> $LOGFILE
echo "#================= Java版本 ====================#" >> $LOGFILE
lslpp -l | grep Java | grep -v idebug | awk '{printf "%-25s %-10s\n", $1,$2}' >> $LOGFILE
echo "#===== 確認上述資訊是否正確? Yes( ) NO( ) ======#" >> $LOGFILE
echo "" >> $LOGFILE

echo "" >> $LOGFILE
echo "#================= Memory 資訊 =================#" >> $LOGFILE
prtconf -m >> $LOGFILE
echo "#===== 確認上述資訊是否正確? Yes( ) NO( ) ======#" >> $LOGFILE
echo "" >> $LOGFILE

echo "" >> $LOGFILE
echo "#================= Page 資訊 ===================#" >> $LOGFILE
lsps -a >> $LOGFILE
echo "#===== 確認上述資訊是否正確? Yes( ) NO( ) ======#" >> $LOGFILE
echo "" >> $LOGFILE

echo "" >> $LOGFILE
echo "#================= 網路裝置 ====================#" >> $LOGFILE
lsdev -C | grep ^en >> $LOGFILE
echo "#===== 確認上述資訊是否正確? Yes( ) NO( ) ======#" >> $LOGFILE
echo "" >> $LOGFILE

echo "" >> $LOGFILE
echo "#================= 光纖裝置 ====================#" >> $LOGFILE
lsdev -C | grep ^fcs >> $LOGFILE
echo "#===== 確認上述資訊是否正確? Yes( ) NO( ) ======#" >> $LOGFILE
echo "" >> $LOGFILE

echo "" >> $LOGFILE
echo "#================= 磁碟路徑 ====================#" >> $LOGFILE
lspath >> $LOGFILE
echo "#===== 確認上述資訊是否正確? Yes( ) NO( ) ======#" >> $LOGFILE
echo "" >> $LOGFILE

echo "" >> $LOGFILE
echo "#================= 網路位址 ====================#" >> $LOGFILE
ifconfig -a | grep "inet " | grep -v "127.0.0.1" | awk '{print $2}' >> $LOGFILE
echo "#===== 確認上述資訊是否正確? Yes( ) NO( ) ======#" >> $LOGFILE
echo "" >> $LOGFILE

echo "" >> $LOGFILE
echo "#================= 路由資訊 ====================#" >> $LOGFILE
netstat -rn | grep -E 'en|lo' | awk '{print $1 "\t" $2}'  | grep -v '::1%1' >> $LOGFILE
echo "#===== 確認上述資訊是否正確? Yes( ) NO( ) ======#" >> $LOGFILE
echo "" >> $LOGFILE

echo "" >> $LOGFILE
echo "#================= 檔案系統 ====================#" >> $LOGFILE
df -gP | grep -Ev '/proc|livedump' | awk '{print $2, "\t" $6}' >> $LOGFILE
echo "#===== 確認上述資訊是否正確? Yes( ) NO( ) ======#" >> $LOGFILE
echo "" >> $LOGFILE

echo "" >> $LOGFILE
echo "#================= Mirror狀態 ==================#" >> $LOGFILE
VGNAME=`lsvg`
for vgname in $VGNAME
do
  lsvg -l $vgname >> $LOGFILE
done
echo "#===== 確認上述資訊是否正確? Yes( ) NO( ) ======#" >> $LOGFILE
echo "" >> $LOGFILE

echo "" >> $LOGFILE
echo "#================= 開機順序 ====================#" >> $LOGFILE
bootlist -m normal -o >> $LOGFILE
echo "#===== 確認上述資訊是否正確? Yes( ) NO( ) ======#" >> $LOGFILE
echo "" >> $LOGFILE

echo "" >> $LOGFILE
echo "#================= ITM agent狀態 ===============#" >> $LOGFILE
/opt/IBM/ITM/bin/cinfo -r | grep "^`hostname`" | awk '{print $1, $2, $4, $7}' >> $LOGFILE
echo "#===== 確認上述資訊是否正確? Yes( ) NO( ) ======#" >> $LOGFILE
echo "" >> $LOGFILE

echo "" >> $LOGFILE
echo "#================= CTM agent狀態 ===============#" >> $LOGFILE
su - twse "shagent" | grep ^twse | grep -v "Password" | awk '{print $1, "\t",$5}'  >> $LOGFILE
echo "#===== 確認上述資訊是否正確? Yes( ) NO( ) ======#" >> $LOGFILE
echo "" >> $LOGFILE

echo "" >> $LOGFILE
echo "#================= 使用者限制 ==================#" >> $LOGFILE
ulimit -a >> $LOGFILE
echo "#===== 確認上述資訊是否正確? Yes( ) NO( ) ======#" >> $LOGFILE
echo "" >> $LOGFILE

echo "" >> $LOGFILE
echo "#============== 使用者帳號與群組================#" >> $LOGFILE
echo "帳號" >> $LOGFILE
lsuser ALL | awk '{printf "%-10s %-15s %-15s %-45s %-10s\n", $1,$2,$3,$4,$5}' >> $LOGFILE
echo "群組" >> $LOGFILE
lsgroup ALL | awk '{printf "%-10s %-15s %-15s %-10s\n", $1,$2,$3,$4}' >> $LOGFILE
echo "#===== 確認上述資訊是否正確? Yes( ) NO( ) ======#" >> $LOGFILE
echo "" >> $LOGFILE

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

echo "" >> $LOGFILE
echo "#================ /TWSE目錄結構 ================#" >> $LOGFILE
find /TWSE -type d -exec ls -ld {} \; | awk '{print $1, "\t" $3, "\t" $4, "\t" $9}' >> $LOGFILE
echo "#===== 確認上述資訊是否正確? Yes( ) NO( ) ======#" >> $LOGFILE
echo "" >> $LOGFILE

echo "" >> $LOGFILE
echo "#================ 系統網路參數 =================#" >> $LOGFILE
no -a >> $LOGFILE
echo "#===== 確認上述資訊是否正確? Yes( ) NO( ) ======#" >> $LOGFILE
echo "" >> $LOGFILE

echo "" >> $LOGFILE
echo "#================ 系統記憶體參數 =================#" >> $LOGFILE
vmo -a | grep -Ev 'pinnable_frames|maxpin|maxperm|minperm'>> $LOGFILE
echo "#===== 確認上述資訊是否正確? Yes( ) NO( ) ======#" >> $LOGFILE
echo "" >> $LOGFILE

echo "" >> $LOGFILE
echo "#================ 系統 Memory & CPU 分部區域 =================#" >> $LOGFILE
lssrad -av >> $LOGFILE
echo "#===== 確認上述資訊是否正確? Yes( ) NO( ) ======#" >> $LOGFILE
echo "" >> $LOGFILE

#Backup base file
cp $LOGFILE $BKLOGFILE 
