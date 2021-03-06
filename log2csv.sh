#!/bin/ksh 
#
#
# log2csv.sh
# paul@coventive.com 2012/05/23
# covert log 2 csv-format
#
# action:
# 1. generate *.csv from *.txt :
#    safelog.${hostname}.faillogin.*.csv
#    pwlog.${hostname}.expire.*.csv
#    safelog.${hostname}.login.*.csv
#    safelog.${hostname}.chuser.*.csv	# by compare alluser.old.txt & alluser.new.txt
#    safelog.${hostname}.history.*.csv
# 2. sort above
# 3. merge above into safelog.${hostname}.logs.$timestamp.csv
# 4. cat safelog.${hostname}.logs.$timestamp.csv >> ${cur_ym}.${hostname}.logs.csv
#
# note:
# resort.sh will del all needed *.txt, so this pgm should run before resort.sh !
#
# History:
# 2012/05/23 1.0a ORG Prototype.
# 2012/05/25 1.1a ADD merge func.
# 2012/05/28 1.2a ADD chuser.
#

#----------------------------------
# Set variable
#----------------------------------
ApName="log2csv"
ApVers="1.2a"
ApDate="2012/05/28"
showstep="1"		# for debug! (1=on , 0=off)
hostname=`hostname`
hostid="    "
DATAPATH="/home/se/safechk/safelog"
now_year=`date +"%Y"`	
now_month=`date +"%m"`	
now_tt=`/usr/bin/perl -e 'print time'`
cur_ymd=`date +"%Y%m%d"`
cur_ym=`date +"%Y%m"`
timestamp=`date +"%Y%m%d%H%M%S"`
outfile0=""
outfile1="${DATAPATH}/safelog.${hostname}.logs.$timestamp.csv"
outfile2="${DATAPATH}/${cur_ym}.${hostname}.logs.csv"
outfile3="${DATAPATH}/safelog.${hostname}.logs_doc.txt"
ulist_old=""
ulist_new=""

mappingHost () {
   hostid=`cat /home/se/safechk/cfg/hostid.lst | grep "^$hostname " | awk '{print $2}'`
}

tlog() {
	msg=$1
	if [ "$showstep" = "1" ]; then
		dt=`date +"%y/%m/%d %H:%M:%S"`
		echo " [${dt}] $msg"
	fi
}


#----------------------------------
# create user account list
#----------------------------------
genUserList() {
	tlog " > genUserList() ..."
	ulist_old=""
	ulist_new=""
	ufile_old="$DATAPATH/alluser.old.txt"
	ufile_new="$DATAPATH/alluser.new.txt"
	ufile_bak="$DATAPATH/${cur_ym}.alluser.bak.txt"

	# ulist=`lsuser -c -a id ALL | grep -v '^#'`
	if [ -f "${ufile_new}" ]; then
		mv ${ufile_new} ${ufile_old}
		rec1=""
		while read rec1
		do
			ulist_old="${ulist_old} $rec1"
		done < ${ufile_old}
	fi

	`lsuser -c -a id pgrp ALL | grep -v '^#' | awk -F':' '{\
	 printf("%s:%s:",$1,$2);
	 cmd=sprintf("lsgroup -c -a id %s | grep -v '^#'", $3);
	 system(cmd);}' | sort > ${ufile_new}`

	rec1=""
	while read rec1
	do
		ulist_new="${ulist_new} $rec1"
	done < ${ufile_new}

	echo ' ' >> ${ufile_bak}
	date >> ${ufile_bak}
	cat ${ufile_new} >> ${ufile_bak}
}

#----------------------------------
# find out uid of uname from yesterday's ulist first,
# if not found then from today's ulist second.
#----------------------------------
getUserList2id() {
	name1=$1
	uid="-1"	# def=-1 for somebody like: UNKNOWN_

	let Cnt=0
	for auser in ${ulist_old} ${ulist_new}
	do
		let Cnt=$Cnt+1
		name0=`echo $auser | awk -F: '{print \$1}'`
		uid0=`echo $auser | awk -F: '{print \$2}'`
		# echo "($Cnt) $auser [$name0,$uid0]"
		if [ "$name0" == "$name1" ]; then
			uid=$uid0
			break
		fi
	done

	echo $uid
}

# "May 23 12:12" to "2012-05-23 12:12:00.000"
# "Mar 21 08:26:16 2012" to "2012-03-21 08:26:16.000"
getTime1() {
	mm1=$1; dd1=$2; hh_mm1=$3

	if [ ${#hh_mm1} -ge 8 ]; then
	 	hh_mm_ss1=$hh_mm1
	else
	 	hh_mm_ss1="${hh_mm1}:00"
	fi

	if [ -n "$4" ]; then
		yyyy1=$4
	else
		yyyy1=$now_year
	fi

	if [ ${#dd1} -eq 1 ]; then
		dd1="0$dd1"
	fi

	# find out number of month.
	let Cnt=0
	for aMM in Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec
	do
		let Cnt=$Cnt+1
		if [ "$aMM" == "$mm1" ]; then
			if [ $Cnt -lt 10 ]; then
				imm="0$Cnt"
			else
				imm="$Cnt"
			fi
			break
		fi
	done

	# if month larger than now, set year = lastyear.
	let inow_mm=$now_month
	if [ ! -n "$4" ] && [ $Cnt -gt $inow_mm ]; then
		let yyyy1=$yyyy1-1
	fi

	timestr="${yyyy1}-${imm}-${dd1} ${hh_mm_ss1}.000"
	echo $timestr
}

getTime2() {
	tt1=$1
	# ts1=`/usr/bin/perl -e 'use POSIX qw(strftime);$str = strftime( "%b %d %H:%M:%S %Y", localtime('$tt1'));print $str'`
	ts1=`/usr/bin/perl -e 'use POSIX qw(strftime);$str = strftime( "%Y-%m-%d %H:%M:%S.000", localtime('$tt1'));print $str'`
	echo $ts1
}

# ex: "ap01      - FTP         May 22 09:00      ?"
convFailLog() {
	name1=$1; from1=$3; mm1=$4; dd1=$5; hh_mm1=$6
	uid=`getUserList2id $name1`
	timestr=`getTime1 $mm1 $dd1 $hh_mm1`
	# ansstr="faillogin,$hostname,$uid,$name1,$from1,$timestr"
	ansstr="$hostname,$name1,$uid,$from1,$timestr"
	echo $ansstr
}

readFailLog() {
	file1=$1
	let cnt=0
        let num=1
	while read rec1
	do
		let cnt=$cnt+1
		# echo "($cnt) $rec1"
		rc=`echo $rec1 | grep '[+-]' | awk '{print NF}'`
		if [ "$rc" == "7" ]; then
			# echo "($cnt) $rec1"
			ans=`convFailLog $rec1`
                        count=`printf "%.7d" $num`        
			echo "$cur_ymd$hostid$count,$ans" >> $outfile
                        let num=num+1
		fi
	done < $file1
}

convPwExpire() {
	name1=$1
	uid=`getUserList2id $name1`

	# last login time.
	lastlogin1=""
	ans=`who /var/adm/wtmp | awk '\$1~/^'${name1}'/{dat=\$0}END{print dat}`
	if [ -n "$ans" ]; then
		tt1=`echo $ans | awk '{print $3,$4,$5}'`
		lastlogin1=`getTime1 $tt1`
	fi

	# last change pw time.
	lastUpdate_t=`pwdadm -q $name1 | grep lastupdate | sed 's/^.*= //'`

	if [ ! -n "$lastUpdate_t" ] || [ "$lastUpdate_t" = '0' ]; then
		lastUpdate=""
	else
		lastUpdate=`getTime2 $lastUpdate_t`
	fi

	# next change pw time.
	nextChange=""
	maxAge=`lsuser -a maxage $name1 | grep '=' | sed 's/^.*=//'`
	if [ -n "$maxAge" ] && [ -n "$lastUpdate_t" ]; then
		# 一天有 86400 秒，乘以 7 得到 604800。所以一周有 604800 秒。
		nextChange_t=`expr 604800 \* $maxAge + $lastUpdate_t`
		nextChange=`getTime2 $nextChange_t`
	fi

	# status of pw expire
	exp_status="0"
	if [ -n "$nextChange_t" ] && [ $now_tt -gt $nextChange_t ]; then
		exp_status="1"
	fi

        # query group name and gid
        pgrpid=`lsuser -c -a id pgrp ALL | grep -v '^#' | grep "^${name1}:" | awk -F: '{print $2}'`
        pgrp=`lsuser -c -a id pgrp ALL | grep -v '^#' | grep "^${name1}:" | awk -F: '{print $3}'`
        grp2=`lsuser -c -a id groups ALL | grep -v '^#' | grep "^${name1}:" | awk -F: '{print $3}'`

	# ansstr="expire,$hostname,$uid,$name1,$lastlogin1,$lastUpdate,$maxAge,$nextChange,$exp_status"
	ansstr="$hostname,$name1,$uid,$lastlogin1,$lastUpdate,$maxAge,$nextChange,$exp_status,$pgrp,$pgrpid,\"$grp2\""
	echo $ansstr
}

readPwExpire() {
	file1=$1
	let cnt=0
        let num=1
	while read rec1
	do
		let cnt=$cnt+1
		# echo "($cnt) $rec1"
		rc=`echo $rec1 | grep '^(' | awk '{print $2}'`
		if [ -n "$rc" ]; then
			ans=`convPwExpire $rc`
                        count=`printf "%.7d" $num`
			echo "$cur_ymd$hostid$count,$ans" >> $outfile
                        let num=num+1
		fi
	done < $file1
}

# root      pts/3        10.199.130.249         May 22 18:41 - 18:41  (00:00)
convLogin() {
	name1=$1; way1=$2; ip1=$3; mm1=$4; dd1=$5; hh_mm1=$6; hh_mm2=$8; tms1=$9
	tms1=`echo $tms1 | sed -e 's/^(//' -e 's/)$//'`

	uid=`getUserList2id $name1`

	logint1=`getTime1 $mm1 $dd1 $hh_mm1`
	logint2=`getTime1 $mm1 $dd1 $hh_mm2`

	# ansstr="login,$hostname,$uid,$name1,$way1,$ip1,$logint1,$logint2,$tms1"
	ansstr="$hostname,$name1,$uid,$way1,$ip1,$logint1,$logint2,$tms1"
	echo $ansstr
}

readLogin() {
	file1=$1
	let cnt=0
        let num=1
	while read rec1
	do
		let cnt=$cnt+1
		# echo "($cnt) $rec1"
		rc=`echo $rec1 | awk '{print NF}'`
		if [ "$rc" == "9" ]; then
			ans=`convLogin $rec1`
                        count=`printf "%.7d" $num`
			echo "$cur_ymd$hostid$count,$ans" >> $outfile
                        let num=num+1
		fi
	done < $file1
}

convHistory() {
	name1=$1; rec1=$2
	ymd1=`echo $rec1 | awk '{print $2}'`
	hms1=`echo $rec1 | awk '{print $3}'`
	cmd1=`echo $rec1 | sed 's/^.*:: //'`

	uid=`getUserList2id $name1`
	timestr=`echo $ymd1 | tr '/' '-'`
	timestr="$timestr ${hms1}.000"

	# ansstr="history,$hostname,$uid,$name1,$timestr,$cmd1"
	ansstr="$hostname,$name1,$uid,$timestr,\"$cmd1\""
	echo $ansstr
}

# (1/57) history of root :
# 3022    2012/05/22 09:19:22 :: cd /tmp/
readHistory() {
	file1=$1
	name1=""
	let cnt=0
        let num=1
	while read rec1
	do
		let cnt=$cnt+1
		# echo "($cnt) $rec1"
		name2=`echo $rec1 | grep '^(' | awk '{print $4}'`
		if [ -n "$name2" ]; then
			name1=$name2
		else
			if [ -n "$name1" ] && [ ${#rec1} -gt 3 ]; then
				ans=`convHistory $name1 "$rec1"`
                                count=`printf "%.7d" $num`
				echo "$cur_ymd$hostid$count,$ans" >> $outfile
                                let num=num+1
			fi
		fi
	done < $file1
}

test1() {
	for name1 in ap01 ada1 ada2 ada4 se01 ada1 UNKNOWN_ ap01
	do
		echo " ...$name1 bgn..."
		uid=`getUserList2id $name1`
		echo " ...$name1 $uid end..."
	done

	str1="May 23 12:12"
	str2=`getTime1 $str1`
	echo " str1[$str1], str2[$str2]"

	str1="Jun  3 12:12"
	str2=`getTime1 $str1`
	echo " str1[$str1], str2[$str2]"

	str1="Mar  1 08:26:16 2012"
	str2=`getTime1 $str1`
	echo " str1[$str1], str2[$str2]"

	tt1="1338446779"
	yt1=`getTime2 $tt1`
	echo " tt1=[$tt1] , yt1=[$yt1]"
}


genEachCsv() {
	tlog " > genEachCsv() ..."

	# (1/5) ---------------------------------------------------------------
	# login fail
	# 欄位:使用者名稱、uid、統計期間、累計上月失敗次數、累計本月失敗次數、本月失敗次數

	# file1="/home/se/safechk/safelog/safelog.dev1.faillogin.20120523050003.txt"
	file1=`ls -tr $DATAPATH | grep '\.txt$' | grep safelog.${hostname}.faillogin.${cur_ymd} | tail -n 1`
	outfile="$DATAPATH/${file1%.txt}.csv"
	if [ -f "$DATAPATH/$file1" ]; then
		tlog "# (1/5) readFailLog file: $DATAPATH/$file1"
		# echo "# (1/5) readFailLog file: $DATAPATH/$file1" >> $outfile
		# echo "# tag,host,id,name,from,time" >> $outfile
		rm -f $outfile
		readFailLog $DATAPATH/$file1
	fi

	# (2/5) ---------------------------------------------------------------
	# 密碼逾期
	# 欄位:使用者名稱、uid、上次登入時間、上次修改密碼時間、過期日期、密碼過期顯示

	# file1="/home/se/safechk/safelog/pwlog.dev1.expire.20120523050003.txt"
	file1=`ls -tr $DATAPATH | grep '\.txt$' | grep pwlog.${hostname}.expire.${cur_ymd} | tail -n 1`
	outfile="$DATAPATH/${file1%.txt}.csv"
	if [ -f "$DATAPATH/$file1" ]; then
		tlog "# (2/5) readPwExpire file: $DATAPATH/$file1"
		# echo "# (2/5) readPwExpire file: $DATAPATH/$file1" >> $outfile
		# echo "# tag,host,id,name,lastlogin,lastupdate,week,nextupdate,isExpire" >> $outfile
		rm -f $outfile
		readPwExpire $DATAPATH/$file1
	fi

	# (3/5) ---------------------------------------------------------------
	# user id使用情形
	# name、uid、連線方式、ip address、cmd、登入時間、登出時間、使用多少時間

	# file1="/home/se/safechk/safelog/safelog.dev1.login.20120523050002.txt"
	file1=`ls -tr $DATAPATH | grep '\.txt$' | grep safelog.${hostname}.login.${cur_ymd} | tail -n 1`
	outfile="$DATAPATH/${file1%.txt}.csv"
	if [ -f "$DATAPATH/$file1" ]; then
		tlog "# (3a/5) readLogin file: $DATAPATH/$file1"
		# echo "# (3a/5) readLogin file: $DATAPATH/$file1" >> $outfile
		# echo "# tag,host,id,name,way,ip,btime,etime,times" >> $outfile
		rm -f $outfile
		readLogin $DATAPATH/$file1
	fi

	# file1="/home/se/safechk/safelog/safelog.dev1.history.20120523050000.txt"
	file1=`ls -tr $DATAPATH | grep '\.txt$' | grep safelog.${hostname}.history.${cur_ymd} | tail -n 1`
	outfile="$DATAPATH/${file1%.txt}.csv"
	if [ -f "$DATAPATH/$file1" ]; then
		tlog "# (3b/5) readHistory file: $DATAPATH/$file1"
		# echo "# (3b/5) readHistory file: $DATAPATH/$file1" >> $outfile
		# echo "# tag,host,id,name,time,cmd" >> $outfile
		rm -f $outfile
		readHistory $DATAPATH/$file1
	fi

	# (4/5) ---------------------------------------------------------------
	# 新增、刪除user
	# 欄位:使用者名稱、groupname、uid、gid

	outfile="${DATAPATH}/safelog.${hostname}.chuser.$timestamp.csv"
	outfiletmp="${DATAPATH}/safelog.${hostname}.chuser0.$timestamp.csv"
	genChUsersCsv


	# (5/5) ---------------------------------------------------------------
	# 值班檢核(檔案)
	# 欄位:異動動作、檔案名稱、檔案位置、權限、檔案大小、日期
	#
	# !!! not yet !!!
}

genChUsersCsv() {
	oldfile="${DATAPATH}/alluser.old.txt"
	newfile="${DATAPATH}/alluser.new.txt"
	tlog " > genChUsersCsv() ... output: $outfile"

	if [ ! -f "${oldfile}" ]; then
		oldfile="";
	fi

	if [ ! -f "${newfile}" ]; then
		newfile="";
	fi

	echo ' ' | \
	awk -v fn1="${oldfile}" -v fn2="${newfile}" '\
		BEGIN{
			neof1 = 1; rec1 = ""; nextln1 = 1; name1 = "";
			neof2 = 1; rec2 = ""; nextln2 = 1; name2 = "";
			if( ! length( fn1 ) ) { neof1=0; nextln1=0; }	# disable
			if( ! length( fn2 ) ) { neof2=0; nextln2=0; }	# disable
		} END{
			while( neof1 || neof2 ) {
				if( nextln1 ) {
					rec1 = "";
					neof1 = getline rec1 < fn1;	# read 1 line from inputfile[i], neof = 1(cont.) or 0(end)
					gsub( /:/, ",", rec1 );
					name1 = rec1; sub( /,.*$/, "", name1 );
				}
				if( nextln2 ) {
					rec2 = "";
					neof2 = getline rec2 < fn2;	# read 1 line from inputfile[i], neof = 1(cont.) or 0(end)
					gsub( /:/, ",", rec2 );
					name2 = rec2; sub( /,.*$/, "", name2 );
				}

				# compare
				ansstr="";
				# print "["rec1"],["rec2"]"

				if( rec1 < rec2 ) {
					if( rec1 ) {
						# normal getline
						if( name1 != name2 ) {
							# act=del
							ansstr=rec1",del,,,,";
							print ansstr
							nextln2 = 0;	# wait for next compare
							nextln1 = 1;	# cont. getline
						} else {
							# act=chg
							ansstr=rec1",chg,"rec2;
							print ansstr
							nextln2 = 1;	# cont. getline
							nextln1 = 1;	# cont. getline
						}
					} else {
						# fn1 already eof, left fn2~
						# act=add
						ansstr=rec2",add,,,,";
						print ansstr
						nextln2 = 1;	# cont. getline
						nextln1 = 0;	# wait for next compare
					}
				} else
				if( rec1 > rec2 ) {
					if( rec2 ) {
						# normal getline
						if( name1 != name2 ) {
							# act=add
							ansstr=rec2",add,,,,";
							print ansstr
							nextln1 = 0;	# wait for next compare
							nextln2 = 1;	# cont. getline
						} else {
							# act=chg
							ansstr=rec1",chg,"rec2;
							print ansstr
							nextln2 = 1;	# cont. getline
							nextln1 = 1;	# cont. getline
						}
					} else {
						# act=del
						ansstr=rec1",del,,,,";
						print ansstr
						nextln1 = 1;	# cont. getline
						nextln2 = 0;	# wait for next compare
					}
				} else
				if( rec1 == rec2 ) {
					# act=no change
					nextln1 = 1; nextln2 = 1;
				}


			}
	}' > $outfiletmp

        ## Add Primary-Key to chuser report
        cat /dev/null > $outfile
        let num=1
        while read line
        do
           count=`printf "%.7d" $num`
           ans="$cur_ymd$hostid$count,$hostname,$line"
           echo $ans >> $outfile
           let num=num+1
        done < $outfiletmp
        rm $outfiletmp
}

sortEachCsv() {
	# sort *.csv
	tlog " > sortEachCsv() ..."

	# file1=`ls -tr $DATAPATH | grep '\.csv$' | grep safelog.${hostname}.faillogin.${cur_ymd} | tail -n 1`
	# file1=`ls -tr $DATAPATH | grep pwlog.${hostname}.expire.${cur_ymd} | tail -n 1`
	# file1=`ls -tr $DATAPATH | grep safelog.${hostname}.login.${cur_ymd} | tail -n 1`
	# file1=`ls -tr $DATAPATH | grep safelog.${hostname}.chuser.${cur_ymd} | tail -n 1`
	# file1=`ls -tr $DATAPATH | grep safelog.${hostname}.history.${cur_ymd} | tail -n 1`

	for afile1 in safelog.${hostname}.faillogin pwlog.${hostname}.expire safelog.${hostname}.login safelog.${hostname}.chuser safelog.${hostname}.history
	do
		# echo " ...sort: target: ${afile1}.${cur_ymd}"
		file1=`ls -tr $DATAPATH | grep '\.csv$' | grep ${afile1}.${cur_ymd} | tail -n 1`
		if [ -n "$file1" ]; then
			file2=${file1}.tmp

			sort $DATAPATH/$file1 > $DATAPATH/$file2
			mv $DATAPATH/$file2 $DATAPATH/$file1
		fi
	done
}

mergeEachCsv() {
	# merge *.csv
	tlog " > mergeEachCsv() ... output: $outfile1"

	fcsv[1]=`ls -tr $DATAPATH | grep '\.csv$' | grep safelog.${hostname}.faillogin.${cur_ymd} | tail -n 1`
	fcsv[2]=`ls -tr $DATAPATH | grep '\.csv$' | grep pwlog.${hostname}.expire.${cur_ymd} | tail -n 1`
	fcsv[3]=`ls -tr $DATAPATH | grep '\.csv$' | grep safelog.${hostname}.login.${cur_ymd} | tail -n 1`
	fcsv[4]=`ls -tr $DATAPATH | grep '\.csv$' | grep safelog.${hostname}.chuser.${cur_ymd} | tail -n 1`
	fcsv[5]=`ls -tr $DATAPATH | grep '\.csv$' | grep safelog.${hostname}.history.${cur_ymd} | tail -n 1`

	let cnt=1
	let cnt2=0
	while [ $cnt -le 5 ]
	do
		if [ -n "${fcsv[${cnt}]}" ]; then
			fcsv[${cnt}]="$DATAPATH/${fcsv[${cnt}]}"
			let cnt2=${cnt2}+1
		fi

		## ex: " ...fcsv[4]=[/home/se/safechk/safelog/safelog.dev1.history.20120525050000.csv]"
		# echo " ...fcsv[${cnt}]=[${fcsv[${cnt}]}]"

		let cnt=${cnt}+1
	done

	if [ $cnt2 -eq 0 ]; then
		echo " > no any matched *.csv be found, merge-file action abort!"
		return 1;
	fi

	if [ ! -f "${outfile3}" ]; then
		echo "# Section0(header)     : name1,uid,hostname" >> ${outfile3}
		echo "# Section1(faillogin)  : from1,timestr" >> ${outfile3}
		echo "# Section2(pw-expire)  : lastlogin1,lastUpdate,maxAge,nextChange,exp_status" >> ${outfile3}
		echo "# Section3(login-time) : way1,ip1,logint1,logint2,tms1" >> ${outfile3}
		echo "# Section4(chuser)     : grp1,gid1,act,name,uid,grp,gid" >> ${outfile3}
		echo "# Section5(cmd-history): timestr,cmd1" >> ${outfile3}
		echo "# total: 23 comma, 24 cols. (but final field=cmd may has comma in content!)" >> ${outfile3}
	fi

	echo ' ' | \
	awk -v fn1="${fcsv[1]}" -v fn2="${fcsv[2]}" -v fn3="${fcsv[3]}" -v fn4="${fcsv[4]}" -v fn5="${fcsv[5]}" -v hostname=$hostname '\
		BEGIN{
			ifn[1]=fn1; ifn[2]=fn2; ifn[3]=fn3; ifn[4]=fn4; ifn[5]=fn5;
			for( i=1; i<=5; i++ ) {
				neof[i]=1; nextln[i]=1; rec[i]=""; rcnt[i]=0; name1[i]=""; uid1[i]=0; name0=""; uid0=0;
				if( ! length( ifn[i] ) ) { neof[i]=0; nextln[i]=0; }	# disable
				# printf( " fn[%d]=[%s], neof[%d]=%d, nextln[%d]=%d,\n", i, ifn[i], i, neof[i], i, nextln[i] );
			}

			# ansstr="$name1,$uid,$from1,$timestr"
			# ansstr="$name1,$uid,$lastlogin1,$lastUpdate,$maxAge,$nextChange,$exp_status"
			# ansstr="$name1,$uid,$way1,$ip1,$logint1,$logint2,$tms1"
			# ansstr="$name1,$uid,$grp1,$gid1,$act,$name1,$uid,$grp,$gid"
			# ansstr="$name1,$uid,$timestr,$cmd1"

			# printf("# Section0(header)     : $name1,$uid,$hostname\n");
			# printf("# Section1(faillogin)  : $from1,$timestr\n");
			# printf("# Section2(pw-expire)  : $lastlogin1,$lastUpdate,$maxAge,$nextChange,$exp_status\n");
			# printf("# Section3(login-time) : $way1,$ip1,$logint1,$logint2,$tms1\n");
			# printf("# Section4(chuser)     : $grp1,$gid1,$act,$name,$uid,$grp,$gid\n");
			# printf("# Section5(cmd-history): $timestr,$cmd1\n");
			# printf("# total: 23 comma, 24 cols. (but final field=cmd may has comma in content!)\n");

			emptycols[1]=",,";	# f1=safelog-faillogin: has 2 cols: from1,timstr, ... , except name1,uid,
			emptycols[2]=",,,,,";	# f2=pwlog-expire:      has 5 cols
			emptycols[3]=",,,,,";	# f3=safelog-login:     has 5 cols
			emptycols[4]=",,,,,,,";	# f4=safelog-chuser:    has 7 cols
			emptycols[5]=",";	# f5=safelog-history:   has 2 cols; think about col=cmd, i dont want to fill ',' at end.
		}
		END{

		# getline rec3 < fn3;
		# printf( "rec3 = !!%s!!\n", rec3 );

		# while( getline rec2 < fn2 ) {
		# printf( "rec2 = !!%s!!\n", rec2 );
		# }

		cnt1=0;
		while( neof[0] || neof[1] || neof[2] || neof[3] || neof[4] ) {
			# rc2 = getline rec2 < fn2;
			# printf( "rec2 = !!%s!! (%d,%d)\n", rec2, rc2, cnt2 );
			cnt1++;
			if( cnt1 > 700 ) break;

			for( i=1; i<=5; i++ ) {
				# printf( " >> step2. chk[%d]: [%s](rcnt=%d,neof=%d,nextln=%d,name1=[%s])\n", i, ifn[i], rcnt[i], neof[i], nextln[i], name1[i] );

				# do when not-eof & allow-read-next-line.
				if ( neof[i] ) {
					if ( nextln[i] ) {
						rec[i] = "";
						neof[i] = getline rec[i] < ifn[i];	# read 1 line from inputfile[i], neof = 1(cont.) or 0(end)
						rcnt[i]++;
						while( neof[i] && length( rec[i] ) < 3 ) { # skip empty-line, read-next-line.
							neof[i] = getline rec[i] < ifn[i];
							rcnt[i]++;
						}

						if( length( rec[i] ) > 3 ) {
							idx = index( rec[i], "," );
							if( idx > 0 ) {
								name1[i] = substr( rec[i], 1, idx-1 );
								rec1 = substr( rec[i], idx+1 ); rec[i] = rec1;
	
								idx = index( rec[i], "," );
								uid1[i] = substr( rec[i], 1, idx-1 );
								rec1 = substr( rec[i], idx+1 ); rec[i] = rec1;
							}
						} else {
							name1[i]=""; uid1[i]=0;		# house-clean if eof!
							if( !neof[i] ) nextln[i] = 0;
						}

						# printf( " >> read[%d-%d]: [%s],[%s](%d,%d)...name1=[%s],[%d]\n", i, rcnt[i], rec[i], ifn[i], rcnt[i], neof[i], name1[i], uid1[i] );
					}
				} else { name1[i]=""; uid1[i]=0; rec[i]=""; }	# house-clean if eof!
				# printf( " >> step2. res[%d]: [%s](rcnt=%d,neof=%d,nextln=%d,name1=[%s],rec=[%s])\n", i, ifn[i], rcnt[i], neof[i], nextln[i], name1[i], rec[i] );
			}

			# there are some line waiting for do
			ansstr="";
			if( rec[0] || rec[1] || rec[2] || rec[3] || rec[4] ) {

				# init name0
				for( i=1; i<=5; i++ ) {
					if( length( name1[i] ) ) { name0 = name1[i]; break; }
				}

				# find out smallest name0 from exist-name1[i]
				for( i=1; i<=5; i++ ) {
					if( length( name1[i] ) ) { if( name0 > name1[i] ) { name0 = name1[i]; uid0 = uid1[i]; } }
				}

				ansstr=name0","uid0","hostname",";

				# decide which name1[i]/rec[i] need be marged
				for( i=1; i<=5; i++ ) {
					nextln[i] = 0;  # set to hold(dont do next-read-line).
					if( length( name1[i] ) ) {
						if( name0 == name1[i] ) {
							nextln[i] = 1;
							ansstr=ansstr""rec[i];
							if( i < 5 ) { ansstr=ansstr","; }
						} else {
							ansstr=ansstr""emptycols[i];
						}
					} else {
						ansstr=ansstr""emptycols[i];
					}
				}
			}
			# if( ansstr ) printf( " >> [%d], [%s]\n", cnt1, ansstr );
			if( ansstr ) printf( "%s\n", ansstr );
		}

		# for( i=1; i<=5; i++ ) { printf( " >> rcnt[%d] = %d,\n", i, rcnt[i] ); }
	}' > $outfile1

	# house clean
	let cnt=1
	while [ $cnt -le 5 ]
	do
		if [ -n "${fcsv[${cnt}]}" ]; then
			rm ${fcsv[${cnt}]}
		fi

		let cnt=${cnt}+1
	done
}

catMonthCsv () {
	tlog " > catMonthCsv() ... "
        for filename in faillogin login chuser history
        do
	  csvname=`ls -tr $DATAPATH | grep '\.csv$' | grep safelog.${hostname}.${filename}.${cur_ymd} | tail -n 1`
          if [ -f "$DATAPATH/$csvname" ]; then
             cat $DATAPATH/${csvname} >> ${DATAPATH}/${cur_ym}.${hostname}.${filename}.csv
             rm -f $DATAPATH/${csvname}
          else
             touch ${DATAPATH}/${cur_ym}.${hostname}.${filename}.csv
          fi
        done

        for filename in expire
        do
	  csvname=`ls -tr $DATAPATH | grep '\.csv$' | grep pwlog.${hostname}.${filename}.${cur_ymd} | tail -n 1`
          if [ -f "$DATAPATH/$csvname" ]; then
             cat $DATAPATH/${csvname} > ${DATAPATH}/${cur_ym}.${hostname}.${filename}.csv
             rm -f $DATAPATH/${csvname}
          else
             touch ${DATAPATH}/${cur_ym}.${hostname}.${filename}.csv
          fi
        done
}

main() {
        mappingHost
	genUserList

	# # test1

	genEachCsv

	sortEachCsv

	#mergeEachCsv

        catMonthCsv

	# final
	#tlog " > cat $outfile1 >> $outfile2"
	#cat $outfile1 >> $outfile2
        #rm $outfile1
}

main

