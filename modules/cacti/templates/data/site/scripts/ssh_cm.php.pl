#!/usr/bin/perl -w

# ---------------------------------------------------
# ARGV[0] = <hostname>  required
# ARGV[1] = <cm.php command>  required
# @ARGV   = [cm.php arguments]  optional
# ---------------------------------------------------

$in_hostname = splice(@ARGV, 0, 1) if ($#ARGV + 1);
$in_cm_command = splice(@ARGV, 0, 1) if ($#ARGV + 1);
$in_cm_args = '';

for $i(@ARGV) {
	$in_cm_args .= $i . ' ';
}

if ( ! defined $in_hostname || ! defined $in_cm_command ) {
	print "usage:\n\n $0 <host> <cm.php command> [cm.php parameters] ..\n\n";
	exit 1;
}

$remote_cmd = "php <%= @deploy_dir %>/serve/scripts/cm.php $in_cm_command $in_cm_args";
print `ssh -qo StrictHostKeyChecking=no cacti\@$in_hostname -i /etc/cacti/id_rsa $remote_cmd`;
