class cacti::agent::apache::apc {

  include 'php5::apache2'

  file {'/usr/local/bin/apc-status.php':
    ensure => file,
    content => template('cacti/agent/apache/apc'),
    require => Class['php5::apache2'],
  }

  file {'/etc/apache2/conf.d/apc-status':
    ensure => file,
    content => template('cacti/agent/apache/apc-status'),
    require => Class['php5::apache2'],
    notify => Service['apache2'],
  }

}