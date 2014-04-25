define cgroups::group (
  $perm_task_uid = 'root',
  $perm_task_gid = 'root',
  $perm_admin_uid = 'root',
  $perm_admin_gid = 'root',
  $controllers = {
    'cpuset' => {
        'cpuset.cpus' => 0,
        'cpuset.mems' => 0,
    }
  }
) {

  require 'cgroups'

  augeas {$name:
    context => '/files/etc/cgconfig.conf',
    changes => template('cgroups/group'),
  }
  ~>

  exec {"cgroup apply ${name}":
    command => 'cgconfigparser -l /etc/cgconfig.conf',
    path => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
    refreshonly => true,
  }

}
