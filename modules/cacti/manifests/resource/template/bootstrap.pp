class cacti::resource::template::bootstrap {

  file {'/usr/share/cacti/templates':
    ensure => directory,
    require => Package['cacti'],
  }

  class {'cacti::resource::template::percona': }

  cacti::resource::template::install {'tcp_connection_status.xml':
    content => template('cacti/data/templates/tcp_connection_status.xml'),
  }

}