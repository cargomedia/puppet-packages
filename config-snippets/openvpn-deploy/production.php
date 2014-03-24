<?php
require_once 'library/Deployment.php';

$dep = new Deployment('production', array(
	'gateway-public'     => '99.192.247.33',
	'netmask-public'     => '255.255.255.240',
	'netmask-private'    => '255.255.255.0',
	'ip-private-network' => '172.20.20.0/24',
	'domain'             => 'fuckbook.com',
	'app-user'           => 'fuckbook',
));


$dep->addRole('manager', 'debian')->addHost('99.192.247.42', 'mgr1', array(
	'ip-public'             => '99.192.247.42',
	'ip-private'            => '172.20.20.42',
	'cacti-db-name'         => 'cacti',
	'cacti-db-user'         => 'cacti',
	'cacti-db-passwd'       => 'kakatus',
	'cacti-sense-db-user'   => 'cacti-sense',
	'cacti-sense-db-passwd' => 'k89as0hlHb2masdi7sgV',
	'openvpn-ip-pool-min'   => '172.20.20.170',
	'openvpn-ip-pool-max'   => '172.20.20.179',
));

$taskWwwUpdate = new Task_WwwUpdate();
$taskWwwUpdate->depends(
	new Task_App_ReleaseGitClone('git@github.com:cargomedia/fuboo.git', 'master', 'www/'),
	new Task_WwwInit(),
	new Task_WwwActivateRestart()
);

$taskSysInstall = new Task_Sys_Install();
$taskSysInstall->depends(
	new Task_Sys_Hostname(),
	new Task_Sys_Packages(),
	new Task_Sys_Files('/'),
	new Task_Sys_ScriptsInstall()
);

$dep->addTasks(
	new Task_WwwSetup(),
	$taskWwwUpdate,
	new Task_SearchIndex(),
	new Task_Sys_AptInitialPurge(),
	$taskSysInstall,
	new Task_Sys_AptUpgrade(),
	new Task_Execute(),
	new Task_Reboot()
);
$dep->run($argv);
