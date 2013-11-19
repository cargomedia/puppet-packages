class cacti::resource::template::percona ($version = '1.1.8'){

  helper::script {'install percona templates':
    content => template('cacti/percona-install.sh'),
    unless => 'true',
    require => User['cacti'],
    timeout => 900,
  }
}