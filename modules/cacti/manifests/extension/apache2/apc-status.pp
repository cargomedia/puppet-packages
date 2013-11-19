class cacti::extension::apache2::apc-status {

  require 'php5::apache2'

  file {'/usr/local/bin/apc-status.php':
    ensure => file,
    content => template('cacti/extension/apc'),
    require => Class['apache2'],
  }

  file {'/etc/apache2/conf.d/apc-status':
    ensure => file,
    content => template('cacti/extension/apc-status'),
    require => Class['apache2'],
    notify => Service['apache2'],
  }
}