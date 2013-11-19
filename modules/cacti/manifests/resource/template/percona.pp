class cacti::resource::template::percona ($version = '1.1.8'){

  helper::script {'install percona templates':
    content => template('cacti/percona-install.sh'),
    unless => "grep -q 'version = \"${version}\"' /usr/share/cacti/site/scripts/ss_get_mysql_stats.php && grep -q 'version = \"${version}\"' /usr/share/cacti/site/scripts/ss_get_by_ssh.php",
    require => User['cacti'],
    timeout => 900,
  }
}