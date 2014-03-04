#!/usr/bin/perl
#---------------------------------------------------------------------
# Set variable
#---------------------------------------------------------------------
$SITE="TSEOA1";
$HOSTNAME=`hostname`;
$DATE=`date +%Y%m%d`;
$SHDIR="/home/se/safechk/safesh";
$SHCFG="/home/se/safechk/cfg";
$LOGDIR="/home/se/safechk/safelog";
$REPORTDIR="/home/se/safechk/selog/log";
$LOG="$LOGDIR/security_report.log";
$WKLPAR="WKLPARA1";
$trailmod=1;
$FIRST=1;
$END=7;
$TOTLELPAR=`wc -l $SHCFG/host.lst|awk '{print $1}'`;
@Menu_no=@ARGV;


if ($#Menu_no != 0) {
    print "usage: Please input a parameter \n";
    print "usage: ./security_report.pl  [$FIRST-$END]  \n";
    exit;
}


#{{{raw data variable
#---------------------------------------------------------------------
# Set raw data variable
#---------------------------------------------------------------------
#ntp check ntp status 
#sys check syschk compare status
#aut check daily_copy running status
#atr check fileaudit bas update status
#adm check Hardware_chk running status
#sba check syschk_base bas update status
$ntp_CHKLOG="$LOGDIR/ntp_chk.$DATE";
$sys_CHKLOG="$LOGDIR/sys_chk.$DATE";
$aut_CHKLOG="$LOGDIR/aut_chk.$DATE";
$atr_CHKLOG="$LOGDIR/atr_chk.$DATE";
$adm_CHKLOG="$LOGDIR/adm_chk.$DATE";
$sba_CHKLOG="$LOGDIR/sba_chk.$DATE";
#}}}

#{{{report file variable
#---------------------------------------------------------------------
# Set report file variable
#---------------------------------------------------------------------

$wkl_REPORT="$REPORTDIR/wkl_report.$DATE";
$ntp_REPORT="$REPORTDIR/ntp_report.$DATE";
$sys_REPORT="$REPORTDIR/sys_report.$DATE";
$aut_REPORT="$REPORTDIR/aut_report.$DATE";
$atr_REPORT="$REPORTDIR/atr_report.$DATE";
$adm_REPORT="$REPORTDIR/adm_report.$DATE";
$sba_REPORT="$REPORTDIR/sba_report.$DATE";
#}}}

#{{{comment lostcount cut
=cut
sub lostcount() {
@ARGV=@_;
$lostlpar=undef;
@lostlpar=undef;

	open (HOSTLIST, "$SHCFG/host.lst") || die "Can't open the $SHCFG/host.lst:$!";

	foreach $lostlpar(<HOSTLIST>){
		chomp($lostlpar);

		open (ROWFILE, "${LOGDIR}/$ARGV[0]") || die "Can't open the ${LOGDIR}/$ARGV[0]:$!";
		@ROW=<ROWFILE>;

		$FLAG=grep( /$lostlpar/,@ROW);

		if ( $FLAG == 0 ){
			#print "$lostlpar, ";
			($lostlpar);
			return ($lostlpar);
		}
	}
	print "\n";
	close HOSTLIST;
	close ROWFILE;

}
=cut
#}}}

#{{{comment ntp_report cut
=cut
sub ntp_report(){

#---------------------------------------------------------------------
#set the variable.
#---------------------------------------------------------------------

chomp (($ARGV)=@_);

	open (HOSTLIST, "$SHCFG/host.lst") || die "Can't open the $SHCFG/host.lst:$!";
		@HOST=<HOSTLIST>;
	close HOSTLIST;

#Count the Row data have the ntp success lpar's number.
#	open (ROWFILE, "$LOGDIR/${ROW}.${DATE}") || die "Can't open the ntp.log:$!";
	open (ROWFILE, "$ntp_CHKLOG") || die "Can't open the ntp.log:$!";
		@ROW=<ROWFILE>;
		seek (ROWFILE,0,0);
		while ( <ROWFILE> ) {
				$SUMLPAR++ if ( $_ =~ /offset/ );
			}
	close ROWFILE;

$TOTLELIST=&count('host.lst');
$DIFF=$TOTLELIST-$SUMLPAR;

#---------------------------------------------------------------------
#	To creative the vioc ntp report file in selog/log/ntp_report.$YYYYMMDD.
#---------------------------------------------------------------------

	open (REPORT, ">$ntp_REPORT") || die "Can't open the ntp.log:$!";

	print REPORT "LPAR 應到:", &count('host.lst'), "台","\n";		
	print REPORT "LPAR 實到:$SUMLPAR" ,"台","\n";		
	print REPORT "LPAR 未到:$DIFF" ,"台","\n";		
	print REPORT "LPAR 未到清單:\n"; 
	foreach $host(@HOST){
		chomp($host);
		$FLAG=grep( /$host$/,@ROW);
		if ( $FLAG == 0 ){
			print REPORT "$host, ";
		}
	}
	print REPORT "\n","#","-"x73,"#","\n\n";		
	print REPORT "日  月    時間                                        校時主機           時間差","\n";
	print REPORT @ROW;
	
	close REPORT;

#---------------------------------------------------------------------
#	To print the vioc ntp report file in selog/log/ntp_report.$YYYYMMDD.
#---------------------------------------------------------------------

	open (REPORT, "<$ntp_REPORT") || die "Can't open the ntp.log:$!";
		print <REPORT>;
	close REPORT;
}

sub adm_report(){

#---------------------------------------------------------------------
#set the variable.
#---------------------------------------------------------------------

chomp (($ARGV)=@_);

	open (HOSTLIST, "$SHCFG/host.lst") || die "Can't open the $SHCFG/host.lst:$!";
		@HOST=<HOSTLIST>;
	close HOSTLIST;

#Count the Row data have the ntp success lpar's number.
	open (ROWFILE, "$adm_CHKLOG") || die "Can't open the ntp.log:$!";
		@ROW=<ROWFILE>;
		seek (ROWFILE,0,0);
		while ( <ROWFILE> ) {
				$SUMLPAR++ if ( $_ =~ /Finished/ );
			}
	close ROWFILE;

$TOTLELIST=&count('host.lst');
$DIFF=$TOTLELIST-$SUMLPAR;

#---------------------------------------------------------------------
#	To creative the adm report file in selog/log/adm_report.$YYYYMMDD.
#---------------------------------------------------------------------

	open (REPORT, ">$adm_REPORT") || die "Can't open the ntp.log:$!";

	print REPORT "LPAR 應到:", &count('host.lst'), "台","\n";		
	print REPORT "LPAR 實到:$SUMLPAR" ,"台","\n";		
	print REPORT "LPAR 未到:$DIFF" ,"台","\n";		
	print REPORT "LPAR 未到清單:\n"; 
	foreach $host(@HOST){
		chomp($host);
		$FLAG=grep( /$host$/,@ROW);
		if ( $FLAG == 0 ){
			print REPORT "$host, ";
		}
	}
	print REPORT "\n","#","-"x73,"#","\n\n";		
	print REPORT " 節點         時間         主機                                   狀態","\n";
	print REPORT @ROW;
	
	close REPORT;

#---------------------------------------------------------------------
#	To print the adm report file in selog/log/adm_report.$YYYYMMDD.
#---------------------------------------------------------------------

	open (REPORT, "<$adm_REPORT") || die "Can't open the ntp.log:$!";
		print <REPORT>;
	close REPORT;
}
=cut
#}}}

#{{{count
sub count() {
@ARGV=@_;
$lines=undef;
	open (FILE,"${SHCFG}/$ARGV[0]" ) or die "Can't open ${SHCFG}/$ARGV[0]:$!";
		$lines++ while (<FILE>);
	close FILE;
	return ($lines);
}
#}}}

#{{{tlog
#---------------------------------------------------------------------
# Show running step status
#---------------------------------------------------------------------
sub tlog(){

chomp (($msg)=@_);
    if ( $trailmod == 1){
	   	chomp ($dt=`date +"%y/%m/%d %H:%M:%S"`);
#		print "$SITE [${dt}] $msg\n";
		return "$SITE [${dt}] $msg\n";
	}
} 
#}}}

#{{{wk_ntp_report
sub wk_ntp_report(){

#---------------------------------------------------------------------
#set the variable.
#---------------------------------------------------------------------
$TLOG=&tlog($HOSTNAME) ;

#---------------------------------------------------------------------
#	To creative the wklpar ntp report file in selog/log/wkl_report.$YYYYMMDD.
#---------------------------------------------------------------------
	open (LOG, "$LOGDIR/ntp.log") || die "Can't open the ntp.log:$!";
	open (REPORT, ">$wkl_REPORT") || die "Can't open the ntp.log:$!";
		@LOG=<LOG>;
		print REPORT "日  月    時間                                        校時主機           時間差","\n";
		print REPORT "#","-"x73,"#","\n";		
		print REPORT $TLOG;
		print REPORT @LOG ;
	close REPORT;
	close LOG;

#---------------------------------------------------------------------
#	To print the wklpar ntp report file in selog/log/wkl_report.$YYYYMMDD.
#---------------------------------------------------------------------
	open (REPORT, "<$wkl_REPORT") || die "Can't open the ntp.log:$!";
		print <REPORT>;
	close REPORT;
}
#}}}

#{{{report
sub report(){

#---------------------------------------------------------------------
#set the variable.
#---------------------------------------------------------------------

chomp (($CHKLOG,$REPORT,$MATCH)=@_);


	open (HOSTLIST, "$SHCFG/host.lst") || die "Can't open the $SHCFG/host.lst:$!";
		@HOST=<HOSTLIST>;
	close HOSTLIST;

#Count the Row data have the key words success lpar's number.
	open (ROWFILE, "$CHKLOG") || die "Can't open the $CHKLOG:$!";
		@ROW=<ROWFILE>;
		seek (ROWFILE,0,0);
		while ( <ROWFILE> ) {
				$SUMLPAR++ if ( $_ =~ /$MATCH/ );
			}
	close ROWFILE;

$TOTLELIST=&count('host.lst');
$DIFF=$TOTLELIST-$SUMLPAR;

#---------------------------------------------------------------------
#	To creative the $REPORT files in selog/log/$REPORT.$YYYYMMDD.
#---------------------------------------------------------------------

	open (REPORT, ">$REPORT") || die "Can't open the $REPORT:$!";

	print REPORT "LPAR 應到:", &count('host.lst'), "台","\n";		
	print REPORT "LPAR 實到:$SUMLPAR" ,"台","\n";		
	print REPORT "LPAR 未到:$DIFF" ,"台","\n";		
	print REPORT "LPAR 未到清單:\n"; 
	foreach $host(@HOST){
		chomp($host);
		$FLAG=grep( /$host$/,@ROW);
		if ( $FLAG == 0 ){
			print REPORT "$host, ";
		}
	}
	print REPORT "\n","#","-"x73,"#","\n\n";		

	#Menu_no 2
	if ( $MATCH eq "offset" ) {
		print REPORT "日  月    時間                                        校時主機           時間差","\n";
	#Menu_no 3
	}elsif ( $MATCH eq "Finished" ) {
		print REPORT " 節點         時間         主機                                   狀態","\n";
	}
	#Menu_no 4
	elsif ( $MATCH =~ /base/ ) {
		print REPORT " 節點         時間         主機                檔案時間                          檔案","\n";
	}
	#Menu_no 5
	elsif ( $MATCH eq "Start" ) {
		print REPORT " 節點         時間         主機                檔案","\n";
	}
	#Menu_no 6
	elsif ( $MATCH eq "attr" ) {
		print REPORT " 節點         時間         主機                                                  檔案","\n";
	}
	elsif ( $MATCH eq "End" ) {
		print REPORT " 節點         時間         主機                         狀態","\n";
	}
	else{
		print "Error:No have other REPORT.";
		exit;
	}
	
	print REPORT @ROW;
	
	close REPORT;

#---------------------------------------------------------------------
#	To print the $REPORT file in selog/log/$REPORT.$YYYYMMDD.
#---------------------------------------------------------------------

	open (REPORT, "<$REPORT") || die "Can't open the ntp.log:$!";
		print <REPORT>;
	close REPORT;
}
#}}}

#{{{main
sub main(){
$Menu_no2=@_[0];

	if ($Menu_no2 == 1 ){
		&wk_ntp_report ; 
	}elsif ($Menu_no2 == 2){
		$MATCH="offset";
		&report($ntp_CHKLOG,$ntp_REPORT,$MATCH) ;
	}elsif ($Menu_no2 == 3){
		$MATCH="Finished";
		&report($adm_CHKLOG,$adm_REPORT,$MATCH) ;
	}elsif ($Menu_no2 == 4){
		$MATCH="base.2";
		&report($sba_CHKLOG,$sba_REPORT,$MATCH) ;
	}elsif ($Menu_no2 == 5){
		$MATCH="Start";
		&report($sys_CHKLOG,$sys_REPORT,$MATCH) ;
	}elsif ($Menu_no2 == 6){
		$MATCH="attr";
		&report($atr_CHKLOG,$atr_REPORT,$MATCH) ;
	}elsif ($Menu_no2 == 7){
		$MATCH="End";
		&report($aut_CHKLOG,$aut_REPORT,$MATCH) ;
	}else{
		print "Please input [$FIRST-$END] parameter \n";
		exit ;
	}
}
#}}}

#{{{menu
sub menu(){
$Menu_no=@_[0];

	#wklpar ntp status report
	if ($Menu_no == 1){
		&main(1) ;
	#All Lpar ntp status report
	}elsif ($Menu_no == 2){
		&main(2) ;
	#Run combind.sh ,check Hardware_chk running status. User:seadm
	}elsif ($Menu_no == 3){
		&main(3) ;
	#check syschk base update status.
	}elsif ($Menu_no == 4){
		&main(4) ;
	#check syschk compare status.
	}elsif ($Menu_no == 5){
		&main(5) ;
	#check fileaudit base update status.
	}elsif ($Menu_no == 6){
		&main(6) ;
	#aut check daily_copy running status
	}elsif ($Menu_no == 7){
		&main(7) ;
	}else{ 
		print "Please input [$FIRST-$END] parameter \n";
		exit ;
	}
}
#}}}

&menu("@Menu_no");
