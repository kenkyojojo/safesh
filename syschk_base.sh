#!/bin/ksh
LOGDIR=/home/se/safechk/file/syschk/base
LOGFILE=$LOGDIR/syschk.`hostname`.base
BKLOGFILE=$LOGDIR/syschk.`hostname`.base.`date +%Y%m%d`
#######################################################

echo "" > $LOGFILE
echo "#================= �D���W�ٸ�T ================#" >> $LOGFILE
hostname >> $LOGFILE
echo "#===== �T�{�W�z��T�O�_���T? Yes( ) NO( ) ======#" >> $LOGFILE 
echo "" >> $LOGFILE

echo "" >> $LOGFILE
echo "#================= �@�~�t�Ϊ��� ================#" >> $LOGFILE
oslevel -s >> $LOGFILE
echo "#===== �T�{�W�z��T�O�_���T? Yes( ) NO( ) ======#" >> $LOGFILE
echo "" >> $LOGFILE

echo "" >> $LOGFILE
echo "#================= Java���� ====================#" >> $LOGFILE
lslpp -l | grep Java | grep -v idebug | awk '{printf "%-25s %-10s\n", $1,$2}' >> $LOGFILE
echo "#===== �T�{�W�z��T�O�_���T? Yes( ) NO( ) ======#" >> $LOGFILE
echo "" >> $LOGFILE

echo "" >> $LOGFILE
echo "#================= Memory ��T =================#" >> $LOGFILE
prtconf -m >> $LOGFILE
echo "#===== �T�{�W�z��T�O�_���T? Yes( ) NO( ) ======#" >> $LOGFILE
echo "" >> $LOGFILE

echo "" >> $LOGFILE
echo "#================= Page ��T ===================#" >> $LOGFILE
lsps -a >> $LOGFILE
echo "#===== �T�{�W�z��T�O�_���T? Yes( ) NO( ) ======#" >> $LOGFILE
echo "" >> $LOGFILE

echo "" >> $LOGFILE
echo "#================= �����˸m ====================#" >> $LOGFILE
lsdev -C | grep ^en >> $LOGFILE
echo "#===== �T�{�W�z��T�O�_���T? Yes( ) NO( ) ======#" >> $LOGFILE
echo "" >> $LOGFILE

echo "" >> $LOGFILE
echo "#================= ���ָ˸m ====================#" >> $LOGFILE
lsdev -C | grep ^fcs >> $LOGFILE
echo "#===== �T�{�W�z��T�O�_���T? Yes( ) NO( ) ======#" >> $LOGFILE
echo "" >> $LOGFILE

echo "" >> $LOGFILE
echo "#================= �Ϻи��| ====================#" >> $LOGFILE
lspath >> $LOGFILE
echo "#===== �T�{�W�z��T�O�_���T? Yes( ) NO( ) ======#" >> $LOGFILE
echo "" >> $LOGFILE

echo "" >> $LOGFILE
echo "#================= ������} ====================#" >> $LOGFILE
ifconfig -a | grep "inet " | grep -v "127.0.0.1" | awk '{print $2}' >> $LOGFILE
echo "#===== �T�{�W�z��T�O�_���T? Yes( ) NO( ) ======#" >> $LOGFILE
echo "" >> $LOGFILE

echo "" >> $LOGFILE
echo "#================= ���Ѹ�T ====================#" >> $LOGFILE
netstat -rn | grep -E 'en|lo' | awk '{print $1 "\t" $2}'  | grep -v '::1%1' >> $LOGFILE
echo "#===== �T�{�W�z��T�O�_���T? Yes( ) NO( ) ======#" >> $LOGFILE
echo "" >> $LOGFILE

echo "" >> $LOGFILE
echo "#================= �ɮרt�� ====================#" >> $LOGFILE
df -gP | grep -Ev '/proc|livedump' | awk '{print $2, "\t" $6}' >> $LOGFILE
echo "#===== �T�{�W�z��T�O�_���T? Yes( ) NO( ) ======#" >> $LOGFILE
echo "" >> $LOGFILE

echo "" >> $LOGFILE
echo "#================= Mirror���A ==================#" >> $LOGFILE
VGNAME=`lsvg`
for vgname in $VGNAME
do
  lsvg -l $vgname >> $LOGFILE
done
echo "#===== �T�{�W�z��T�O�_���T? Yes( ) NO( ) ======#" >> $LOGFILE
echo "" >> $LOGFILE

echo "" >> $LOGFILE
echo "#================= �}������ ====================#" >> $LOGFILE
bootlist -m normal -o >> $LOGFILE
echo "#===== �T�{�W�z��T�O�_���T? Yes( ) NO( ) ======#" >> $LOGFILE
echo "" >> $LOGFILE

echo "" >> $LOGFILE
echo "#================= ITM agent���A ===============#" >> $LOGFILE
/opt/IBM/ITM/bin/cinfo -r | grep "^`hostname`" | awk '{print $1, $2, $4, $7}' >> $LOGFILE
echo "#===== �T�{�W�z��T�O�_���T? Yes( ) NO( ) ======#" >> $LOGFILE
echo "" >> $LOGFILE

echo "" >> $LOGFILE
echo "#================= CTM agent���A ===============#" >> $LOGFILE
su - twse "shagent" | grep ^twse | grep -v "Password" | awk '{print $1, "\t",$5}'  >> $LOGFILE
echo "#===== �T�{�W�z��T�O�_���T? Yes( ) NO( ) ======#" >> $LOGFILE
echo "" >> $LOGFILE

echo "" >> $LOGFILE
echo "#================= �ϥΪ̭��� ==================#" >> $LOGFILE
ulimit -a >> $LOGFILE
echo "#===== �T�{�W�z��T�O�_���T? Yes( ) NO( ) ======#" >> $LOGFILE
echo "" >> $LOGFILE

echo "" >> $LOGFILE
echo "#============== �ϥΪ̱b���P�s��================#" >> $LOGFILE
echo "�b��" >> $LOGFILE
lsuser ALL | awk '{printf "%-10s %-15s %-15s %-45s %-10s\n", $1,$2,$3,$4,$5}' >> $LOGFILE
echo "�s��" >> $LOGFILE
lsgroup ALL | awk '{printf "%-10s %-15s %-15s %-10s\n", $1,$2,$3,$4}' >> $LOGFILE
echo "#===== �T�{�W�z��T�O�_���T? Yes( ) NO( ) ======#" >> $LOGFILE
echo "" >> $LOGFILE

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

echo "" >> $LOGFILE
echo "#================ /TWSE�ؿ����c ================#" >> $LOGFILE
find /TWSE -type d -exec ls -ld {} \; | awk '{print $1, "\t" $3, "\t" $4, "\t" $9}' >> $LOGFILE
echo "#===== �T�{�W�z��T�O�_���T? Yes( ) NO( ) ======#" >> $LOGFILE
echo "" >> $LOGFILE

echo "" >> $LOGFILE
echo "#================ �t�κ����Ѽ� =================#" >> $LOGFILE
no -a >> $LOGFILE
echo "#===== �T�{�W�z��T�O�_���T? Yes( ) NO( ) ======#" >> $LOGFILE
echo "" >> $LOGFILE

echo "" >> $LOGFILE
echo "#================ �t�ΰO����Ѽ� =================#" >> $LOGFILE
vmo -a | grep -Ev 'pinnable_frames|maxpin|maxperm|minperm'>> $LOGFILE
echo "#===== �T�{�W�z��T�O�_���T? Yes( ) NO( ) ======#" >> $LOGFILE
echo "" >> $LOGFILE

echo "" >> $LOGFILE
echo "#================ �t�� Memory & CPU �����ϰ� =================#" >> $LOGFILE
lssrad -av >> $LOGFILE
echo "#===== �T�{�W�z��T�O�_���T? Yes( ) NO( ) ======#" >> $LOGFILE
echo "" >> $LOGFILE

#Backup base file
cp $LOGFILE $BKLOGFILE 
