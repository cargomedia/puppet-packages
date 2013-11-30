#!/usr/bin/env perl

$number_of_controllers = `arcconf getversion | awk '/^Controllers found:.*\$/{print \$3}'`;
for ($controller = 1; $controller <= $number_of_controllers; $controller++) {
	$config = `arcconf getconfig $controller PD`;
	foreach ($config =~ /(Device #\d+.+?MaxCache Assigned[^\n]*)/sg) {
		if ($_ !~ /Write Cache\s*:\s*Disabled/ && $_ =~ /Reported Channel,Device\(T:L\)\s*:\s*(\d+),(\d+)\(\d+:\d+\)/) {
			print "$controller\t$1\t$2\n";
		}
	}
}
