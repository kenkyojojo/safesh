#!/usr/bin/perl
#---------------------------------------------------------------------
# Set variable
#---------------------------------------------------------------------
$SITE="TSEOT1";
$HOSTNAME=`hostname`;
$DATE=`date +%Y%m%d`;
$SHDIR="/home/se/safechk/safesh";
$SHCFG="/home/se/safechk/cfg";
$LOGDIR="/home/se/safechk/safelog";
$REPORTDIR="/home/se/safechk/selog/log";
$LOG="$LOGDIR/security_report.log";
$WKLPAR="WKLPART1";
$trailmod=1;
$TOTLELPAR=`wc -l $SHCFG/host.lst|awk '{print $1}'`;
$GARVG=$1;

#---------------------------------------------------------------------
# Set raw data variable
#---------------------------------------------------------------------

$ntp_CHKLOG="$LOGDIR/ntp_chk.$DATE";
$sys_CHKLOG="$LOGDIR/sys_chk.$DATE";
$aut_CHKLOG="$LOGDIR/aut_chk.$DATE";
$atr_CHKLOG="$LOGDIR/atr_chk.$DATE";
$adm_CHKLOG="$LOGDIR/adm_chk.$DATE";
$sba_CHKLOG="$LOGDIR/sba_chk.$DATE";
#---------------------------------------------------------------------
# Set report file variable
#---------------------------------------------------------------------

$ntp_REPORT="$REPORTDIR/ntp_report.$DATE";
$sys_REPORT="$REPORTDIR/sys_report.$DATE";
$aut_REPORT="$REPORTDIR/aut_report.$DATE";
$atr_REPORT="$REPORTDIR/atr_report.$DATE";
$adm_REPORT="$REPORTDIR/adm_report.$DATE";
$sba_REPORT="$REPORTDIR/sba_report.$DATE";

#---------------------------------------------------------------------
# Show running step status
#---------------------------------------------------------------------

sub count() {
@ARGV=@_;
#chomp (($ARGV)=@_);
#open (FILE, $ARGV[0]) or die "Can't open '$ARGV[0]': $!";
#open (FILE,"${SHCFG}/host.lst" ) or die "Can't open ${SHCFG}/host.lst:$!";
	open (FILE,"${SHCFG}/$ARGV[0]" ) or die "Can't open ${SHCFG}/$ARGV[0]:$!";
		$lines++ while (<FILE>);
	close FILE;
#print "$lines\n";
	return ($lines);
}

sub tlog(){
chomp (($msg)=@_);
#(@msg)=@_;
    if ( $trailmod == 1){
	   	chomp ($dt=`date +"%y/%m/%d %H:%M:%S"`);
		print "$SITE [${dt}] $msg\n";
#		return "$SITE [${dt}] $msg\n";
	}
} 

sub wk_ntp_report(){

	open (LOG, "$LOGDIR/ntp.log") || die "Can't open the ntp.log:$!";
		&tlog($HOSTNAME) ;
		print "日  月    時間                                        校時主機           時間差","\n";
		print <LOG> ;
	close LOG;
}

sub ntp_report(){

	open (FILE, "$LOGDIR/ntp_chk.20130916") || die "Can't open the ntp.log:$!";
		while ( <FILE> ) {
			$sumlpar++ if ( $_ =~ /offset/ );
		}
	close FILE;

#	print "LPAR 總數為:", &count('host.lst'), "台","\n";		
#	print "LPAR 數現為:$sumlpar" ,"台","\n";		
#	print "#","-"x73,"#","\n\n";		

	open (HOSTLIST, "$SHCFG/host.lst") || die "Can't open the $SHCFG/host.lst:$!";
	open (ROWFILE, "$LOGDIR/ntp_chk.20130916") || die "Can't open the $LOGDIR/ntp_chk.20130916:$!";

		foreach $hostlist(<HOSTLIST>) {
			chomp ($hostlist);
			print "\$hostlist -> $hostlist\n";

		while ($ROW=<ROWFILE>) {	
#			$ROW=($_);
			chomp ($ROW);
			print "\$ROW-> $Row\n";

#				$find=grep ($hostlist, $ROW);
#				print "$find\n";
#			foreach $hostlist(<HOSTLIST>) {
#			while (<HOSTLIST>){
#$hostlist=($_);
#			chomp $hostlist;

#			print '$ROW ->' ,$ROW,"\n"; 
#			print '$hostlist ->' , $hostlist,"\n";

#			if ( $ROW =~ /$hostlist/ ) {
#					print \$hostlist -> $hostlist,"\n";
#					print \$ROW-> $ROW,"\n";
#				}
			}
		}

#		foreach $row(<ROWFILE>){
#			print $row ;
#		}

	close HOSTLIST;
	close ROWFILE;

#	open (ROWFILE, "$LOGDIR/ntp_chk.20130916") || die "Can't open the ntp.log:$!";
#	print "日  月    時間                                        校時主機           時間差","\n";
#	print <ROWFILE>;
#	close ROWFILE;
}

sub main(){
#$RVR=&tlog($HOSTNAME);
#	&tlog($HOSTNAME);
#	print $RVR
#&wk_ntp_report ;
	&ntp_report ;
#print &count('host.lst'),"\n";
}

&main ;
