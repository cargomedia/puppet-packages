class jenkins(
  $hostname,
  $port = 8080,
  $emailAdmin = 'root@localhost',
  $emailSuffix = '@localhost',
  $numExecutors = 1,
  $clusterId = undef
) {

  require 'jenkins::package'
  require 'jenkins::common'
  include 'jenkins::service'

  class {'jenkins::config::main':
    numExecutors => $numExecutors,
  }
  include 'jenkins::config::credentials'

  file {'/var/lib/jenkins/plugins':
    ensure => 'directory',
    owner => 'jenkins',
    group => 'nogroup',
    mode => '0755',
  }

  file {'/var/lib/jenkins/jobs':
    ensure => 'directory',
    owner => 'jenkins',
    group => 'nogroup',
    mode => '0755',
  }

  file {'/etc/default/jenkins':
    ensure => file,
    content => template("${module_name}/default"),
    owner => '0',
    group => '0',
    mode => '0644',
    notify => Service['jenkins'],
  }

  if $clusterId != undef {
    ssh::auth::id {"jenkins@cluster-${clusterId}":
      user => 'jenkins',
    }
  }

}
