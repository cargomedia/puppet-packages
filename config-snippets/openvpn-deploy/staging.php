<?php
require_once 'library/Deployment.php';

$domain = 'fuckbook.staging.cargomedia';
if (false !== stripos(gethostname(), 'ci')) {
	$domain = 'fuckbook.ci.cargomedia';
}

$dep = new Deployment('staging', array(
	'ip-private-network' => '10.10.10.0/24',
	'domain'             => $domain,
	'app-user'           => 'fuckbook',
));
$dep->setSkipStrictHostKeyChecking(true);


$dep->addRole('manager', 'debian')->addHost('10.10.10.109', 'mgr1', array(
	'ip-public'             => '10.10.10.109',
	'ip-private'            => '10.10.10.109',
	'cacti-db-name'         => 'cacti',
	'cacti-db-user'         => 'cacti',
	'cacti-db-passwd'       => 'kakatus',
	'cacti-sense-db-user'   => 'cacti-sense',
	'cacti-sense-db-passwd' => 'k89as0hlHb2masdi7sgV',
	'openvpn-ip-pool-min'   => '10.10.10.170',
	'openvpn-ip-pool-max'   => '10.10.10.179',
));

$taskWwwUpdate = new Task_WwwUpdate();
$taskWwwUpdate->depends(
	new Task_App_ReleaseCopy('www'),
	new Task_WwwInit(),
	new Task_WwwActivateRestart(true)
);

$taskSysInstall = new Task_Sys_Install();
$taskSysFiles = new Task_Sys_Files('/', array(
	'#^/root/.ssh/authorized_keys$#',
	'#^/etc/network/#',
	'#^/etc/cron.d/fuckbook$#',
	'#^/etc/cron.d/backup$#',
	'#^/etc/cron.d/backup-check$#',
	'#^/etc/resolv.conf$#',
));
$taskSysInstall->depends(
	new Task_Sys_Hostname(),
	new Task_Sys_Packages(),
	$taskSysFiles,
	new Task_Sys_ScriptsInstall()
);

$dep->addTasks(
	new Task_WwwSetup(),
	$taskWwwUpdate,
	new Task_App_Phpunit(),
	new Task_SearchIndex(),
	new Task_Sys_AptInitialPurge(),
	$taskSysInstall,
	new Task_Sys_AptUpgrade(),
	new Task_Execute(),
	new Task_Reboot()
);
$dep->run($argv);
