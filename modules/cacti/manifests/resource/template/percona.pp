class cacti::resource::template::percona ($version = '1.1.8'){

  helper::script {'install percona templates':
    content => template('cacti/resource/percona-install.sh'),
    unless  => "grep -q 'version = \"${version}\"' /usr/share/cacti/site/scripts/ss_get_mysql_stats.php && grep -q 'version = \"${version}\"' /usr/share/cacti/site/scripts/ss_get_by_ssh.php",
    timeout => 900,
  }
  ->

  helper::script {'cacti post install':
    content => template('cacti/resource/post-install.sh'),
    unless  => 'test -e /usr/share/cacti/lib || test -e /usr/share/cacti/include',
    timeout => 900,
    require => Class['cacti::resource::bootstrap'],
  }

}