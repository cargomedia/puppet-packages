class apache2 {

  include 'apache2::service'

  file {'/etc/apache2':
    ensure => directory,
    owner => '0',
    group => '0',
    mode => '0755',
  }

  file {'/etc/apache2/apache2.conf':
    ensure => file,
    content => template('apache2/apache2.conf'),
    group => '0',
    owner => '0',
    mode => '0644',
    notify => Service['apache2'],
  }
  ->

  package {'apache2':
    ensure => present,
  }
}
