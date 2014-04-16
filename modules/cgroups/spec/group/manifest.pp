node default {

  cgroups::cgconfig::group {'puppet':
    controllers => {
      'cpuset' => {
        'cpuset.cpus' => 0,
        'cpuset.mems' => 0
      }
    }
  }

  cgroups::cgconfig::group {'vagrant':
    perm_task_uid => 'vagrant',
    perm_task_gid => 'vagrant',
    perm_admin_uid => 'vagrant',
    perm_admin_gid => 'vagrant',
    controllers => {
      'cpu' => {
        'cpu.shares' => 200
      },
      'cpuset' => {
        'cpuset.cpus' => 0,
        'cpuset.mems' => 0
      }
    }
  }

}
