class cron {

  require 'apt'

  package { 'cron':
    ensure   => present,
    provider => 'apt',
  }
  ->

  service { 'cron':
    enable => true,
  }

  @monit::entry { 'cron':
    content => template("${module_name}/monit"),
    require => Service['cron'],
  }
}
