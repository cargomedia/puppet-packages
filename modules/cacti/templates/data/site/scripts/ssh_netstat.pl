#!/usr/bin/perl -w

# Source:
# http://jose-manuel.me/2012/05/how-to-graph-tcp-connection-status-with-cacti/
# http://forums.cacti.net/viewtopic.php?f=12&t=12787
# Modified by Philipp.Gysin@cargomedia.ch

# ---------------------------------------------------
# ARGV[0] = <hostname> 		required
# ARGV[0] = [timeout(sec)]    optional (default: 240)
# ---------------------------------------------------
$in_hostname 	= $ARGV[0] if defined $ARGV[0];

# usage notes
if ( ! defined $in_hostname ) {
	print "usage:\n\n $0 <host>\n\n";
	exit 1;
}

my $_cmd	= "ssh -qo StrictHostKeyChecking=no cacti\@$in_hostname -i /etc/cacti/id_rsa netstat -tn";

my $_estab      = 0;
my $_listen     = 0;
my $_timewait   = 0;
my $_timeclose  = 0;
my $_finwait1   = 0;
my $_finwait2   = 0;
my $_synsent    = 0;
my $_synrecv    = 0;
my $_closewait  = 0;

my @_output = `$_cmd`;

foreach ( @_output ) {
	$_estab++ 	if /ESTABLISHED/;
	$_listen++ 	if /LISTEN/;
	$_timewait++ 	if /TIME_WAIT/;
	$_timeclose++ 	if /TIME_CLOSE/;
	$_finwait1++ 	if /FIN_WAIT1/;
	$_finwait2++ 	if /FIN_WAIT2/;
	$_synsent++ 	if /SYN_SENT/;
	$_synrecv++ 	if /SYN_RECV/;
	$_closewait++ 	if /CLOSE_WAIT/;
}

print "established:$_estab listen:$_listen timewait:$_timewait timeclose:$_timeclose finwait1:$_finwait1 finwait2:$_finwait2 synsent:$_synsent synrecv:$_synrecv closewait:$_closewait";

