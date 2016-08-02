class cron {

  require 'apt'

  package { 'cron':
    ensure   => present,
    provider => 'apt',
  }

  # see https://github.com/cargomedia/puppet-packages/pull/1414#issuecomment-236863404
  if $::facts['lsbdistcodename'] == 'wheezy' {

    service { 'cron':
      enable => true,
    }

    @monit::entry { 'cron':
      content => template("${module_name}/monit"),
      require => Service['cron'],
    }

  } else {

    daemon { 'cron':
      binary => '/usr/sbin/cron',
      args   => '-f',
    }
  }
}
