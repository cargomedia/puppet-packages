class cacti::resource::site::bootstrap (
  $scriptDir        = $cacti::params::scriptDir,
  $deployDir        = $cacti::params::deployDir,
  $dbSenseUser      = $cacti::params::dbSenseUser,
  $dbSensePassword  = $cacti::params::dbSensePassword
) inherits cacti::params {

  if ($deployDir == undef) {
    fail("Please specify deployDir param for scripts!")
  }

  file {$scriptDir:
    ensure => directory,
    require => Package['cacti'],
  }
  ->

  cacti::resource::site::script {'curl_apc-status.sh':
    content => template('cacti/data/site/scripts/curl_apc-status.sh'),
    scriptDir => $scriptDir,
  }

  cacti::resource::site::script {'ss_get_by_ssh.php.cnf':
    content => template('cacti/data/site/scripts/ss_get_by_ssh.php.cnf'),
    scriptDir => $scriptDir,
  }

  cacti::resource::site::script {'ss_get_mysql_stats.php.cnf':
    content => template('cacti/data/site/scripts/ss_get_mysql_stats.php.cnf'),
    scriptDir => $scriptDir,
    dbSenseUser => $dbSenseUser,
    dbSensePassword => $dbSensePassword,
  }

  cacti::resource::site::script {'ssh_cm.php.pl':
    content => template('cacti/data/site/scripts/ssh_cm.php.pl'),
    scriptDir => $scriptDir,
    deployDir => $deployDir,
  }

  cacti::resource::site::script {'ssh_netstat.pl':
    content => template('cacti/data/site/scripts/ssh_netstat.pl'),
    scriptDir => $scriptDir,
  }
}