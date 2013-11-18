class cron {

  package {'cron':
    ensure => present,
  }
  ->

  service {'cron':}

  @monit::entry {'cron':
    content => template('cron/monit'),
    require => Service['cron'],
  }
}
