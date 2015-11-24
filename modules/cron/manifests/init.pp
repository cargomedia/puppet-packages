class cron {

  require 'apt'

  package { 'cron':
    provider => 'apt',
    ensure => present,
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
