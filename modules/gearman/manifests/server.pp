class gearman::server {

  require 'apt::source::cargomedia'

  package {'gearman-job-server':
    ensure => present,
  }

  service {'gearman-job-server':
    hasrestart => true,
    require => Package['gearman-job-server'],
  }

  @monit::entry {'gearman-job-server':
    content => template('gearman/monit'),
    require => Service['gearman-job-server'],
  }

  @bipbip::entry {'gearman-job-server':
    plugin => 'gearman',
    options => {
      'hostname' => 'localhost',
      'port' => '4730',
    },
    require => Service['gearman-job-server'],
  }

}
