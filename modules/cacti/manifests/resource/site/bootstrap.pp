class cacti::resource::site::bootstrap (
  $deploy_dir         = undef,
  $db_sense_user      = 'cacti-sense',
  $db_sense_password  = 'password'
) {

  if ($deploy_dir == undef) {
    fail("Please specify deployDir param for scripts!")
  }

  Cacti::Resource::Site::Script {
    deploy_dir => $deploy_dir,
    db_sense_user => $db_sense_user,
    db_sense_password => $db_sense_password,
  }

  cacti::resource::site::script {'curl_apc-status.sh':
    content => template('cacti/data/site/scripts/curl_apc-status.sh'),
  }

  cacti::resource::site::script {'ss_get_by_ssh.php.cnf':
    content => template('cacti/data/site/scripts/ss_get_by_ssh.php.cnf'),
  }

  cacti::resource::site::script {'ss_get_mysql_stats.php.cnf':
    content => template('cacti/data/site/scripts/ss_get_mysql_stats.php.cnf'),
  }

  cacti::resource::site::script {'ssh_cm.php.pl':
    content => template('cacti/data/site/scripts/ssh_cm.php.pl'),
  }

  cacti::resource::site::script {'ssh_netstat.pl':
    content => template('cacti/data/site/scripts/ssh_netstat.pl'),
  }

}