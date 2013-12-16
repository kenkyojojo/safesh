#!/usr/bin/perl

$APP02A="/TWSE/appia/applogs/FW202/APP0A";
$APP02B="/TWSE/appia/applogs/FW202/APP0B";
$APP01="/TWSE/appia/applogs/FW101/APP01";
@APP02=($APP02A,$APP02B);

@APPDIR=($APP01,@APP02);

sub object{
#########################################
$WAP01="w = \"TEST_FW101_WR\"";
$RAP01="r = \"TEST_FW101_RD\"";
$XAP01="x = \"TEST_FW101_EX\"";
#########################################
$WAP02="w = \"TEST_FW202_WR\"";
$RAP02="r = \"TEST_FW202_RD\"";
$XAP02="x = \"TEST_FW202_EX\"";
#########################################

open (TARGETF,">/etc/security/audit/objects"); 
    foreach $DDLIST (@APPDIR){
    opendir (OPENDIR,"$DDLIST") or die "Please to check the directory.\n $!" ;
	  if ($DDLIST =~ /$APP01/){
        foreach (readdir(OPENDIR)){
			if ($_ =~ /[^\.]+/){
				chomp $_;
				print TARGETF "\n";
				print TARGETF "${DDLIST}\/$_:\n";
       			print TARGETF ' 'x8; print TARGETF "$WAP01\n";
		       	print TARGETF ' 'x8; print TARGETF "$RAP01\n";
       			print TARGETF ' 'x8; print TARGETF "$XAP01\n";
		    }
        }
	  }else{
			if ($_ =~ /[^\.]+/){
				chomp $_;
				print TARGETF "\n";
				print TARGETF "${DDLIST}\/$_:\n";
       			print TARGETF ' 'x8; print TARGETF "$WAP02\n";
		       	print TARGETF ' 'x8; print TARGETF "$RAP02\n";
       			print TARGETF ' 'x8; print TARGETF "$XAP02\n";
	  }
    }
close TARGETF;
closedir DIR;
}

sub event{

$EVENT_W='TEST_FILE_WR = printf "mode: %o, who: %d, euid: %d egid: %d epriv: %x:%x name %s path: %s file descriptor = %d filename = %s"';
$EVENT_R='TEST_FILE_RD = printf "mode: %o, who: %d, euid: %d egid: %d epriv: %x:%x name %s path: %s file descriptor = %d filename = %s"';
$EVENT_X='TEST_FILE_EX = printf "mode: %o, who: %d, euid: %d egid: %d epriv: %x:%x name %s path: %s file descriptor = %d filename = %s"';

open (TARGETF,">/etc/security/audit/events"); 
    foreach $DD (@APPDIR){
    opendir (DIR,"$DD") or die "Please to check the directory.\n $!" ;
        foreach (readdir(DIR)){
			if ($_ =~ /[^\.]+/){
				chomp $_;
				print TARGETF "\n";
				print TARGETF "\* ${DD}\/$_:\n";
				print TARGETF "\n";
       			print TARGETF ' 'x8; print TARGETF "$EVENT_W \n";
		       	print TARGETF ' 'x8; print TARGETF "$EVENT_R \n";
       			print TARGETF ' 'x8; print TARGETF "$EVENT_X \n";
		    }
        }
    }
close TARGETF;
closedir DIR;
}



sub main {
	&object;
#	&event;
}

&main;
