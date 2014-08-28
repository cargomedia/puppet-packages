class cron {

  package {'cron':
    ensure => present,
  }
  ->

  service {'cron':}

  @monit::entry {'cron':
    content => template("${module_name}/monit"),
    require => Service['cron'],
  }
}
