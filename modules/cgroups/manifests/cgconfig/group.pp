define cgroups::cgconfig::group (
  $perm_task_uid = 'root',
  $perm_task_gid = 'root',
  $perm_admin_uid = 'root',
  $perm_admin_gid = 'root',
  $controllers = {
    'cpu' => {
        'cpu.shares' => 1024
    }
  }
) {

  require 'cgroups'

  augeas {"$name" :
    context => "/files/etc/cgconfig.conf",
    changes => template('cgroups/cgconfig/group'),
  }

}
