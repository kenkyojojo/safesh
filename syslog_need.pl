#!/usr/bin/perl	-w
use strict;

my $command;
my $start_time = `date +%Y-%m-%d_%H:%M:%S`;
my $syslog_dir = '/var/log/syslog';

##################################################
## 3.Build directory and files for ul agent	##
##   then check	it				##
##################################################
`mkdir -p /var/log/syslog`;
my %file_relation = (
	"/var/log/syslog/critical_files" => "D",
	"/var/log/syslog/auth_files" =>	"D",
	"/var/log/syslog/user_files" =>	"D",
	"/var/log/syslog/sftp_files" =>	"D",
	"/var/log/syslog/critical" => "F",
	"/var/log/syslog/auth" => "F",
	"/var/log/syslog/user" => "F",
	"/var/log/syslog/sftp" => "F",
);

if (!-e	"$syslog_dir")
{
   build_dir($syslog_dir);
}

while (my ($path, $type) = each	(%file_relation))
{
   ## Build directory and files
   if (	$type eq 'D' )
   {
      build_dir($path);
   }
   elsif ( $type eq 'F'	)
   {
      build_file($path);
   }
}


##################################################
## Subroutine					##
##################################################
sub build_dir
{
   my $directory = shift;
   my $command;

   if (-e $directory)
   {
      $command = "/usr/bin/mv $directory $directory.bak_$start_time";
      `$command`;
      $command = "/usr/bin/mkdir -p $directory";
      `$command`;
   }
   else
   {
      $command = "/usr/bin/mkdir -p $directory";
      `$command`;
   }

   return;
}

sub build_file
{
   my $file = shift;
   my $command;
   if (-e $file)
   {
      $command = "/usr/bin/mv $file $file.bak_$start_time";
      `$command`;
      $command = "/usr/bin/touch $file";
      `$command`;
   }
   else
   {
      $command = "/usr/bin/touch $file";
      `$command`;
   }

   return;
}
