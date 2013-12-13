class php5::apache2 {

  require 'php5'
  require '::apache2'
  include '::apache2::service'

  file { '/etc/php5/apache2':
    ensure => directory,
    owner => '0',
    group => '0',
    mode => '0644',
  }

  php5::config {'/etc/php5/apache2/php.ini':
    before => Package['libapache2-mod-php5'],
    notify => Service['apache2'],
  }

  package { 'libapache2-mod-php5':
    ensure => present,
    require => [Class['php5'], Class['::apache2']],
    notify => Service['apache2'],
  }
}
