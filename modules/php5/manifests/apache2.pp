class php5::apache2 ($displayErrors = true) {

  include '::apache2::service'
  require 'php5'

  file { '/etc/php5/apache2':
    ensure => directory,
    owner => '0',
    group => '0',
    mode => '0755',
  }

  file { '/etc/php5/apache2/php.ini':
    ensure => file,
    content => template('php5/apache2/php.ini'),
    owner => '0',
    group => '0',
    mode => '0644',
    notify => Service['apache2'],
  }
  ->

  package { 'libapache2-mod-php5':
    ensure => present,
    notify => Service['apache2']
  }
}
