define cgroups::mount ($path) {

  require 'cgroups'

  exec {"mount point ${path}":
    command => "mkdir -p ${path}",
    path => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
  }
  ->

  augeas {"$name" :
    context => "/files/etc/cgconfig.conf",
    changes => template('cgroups/mount'),
  }
  ~>

  exec {"cgroup apply ${name}":
    command => "cgconfigparser -l /etc/cgconfig.conf",
    path => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
  }

}
