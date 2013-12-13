class php5 {

  file { '/etc/php5':
    ensure => directory,
    owner => '0',
    group => '0',
    mode => '0755',
  }

  file { '/etc/php5/conf.d':
    ensure => directory,
    owner => '0',
    group => '0',
    mode => '0755',
  }

  file { '/etc/php5/cli':
    ensure => directory,
    owner => '0',
    group => '0',
    mode => '0755',
  }

  php5::config { '/etc/php5/cli/php.ini':
    before => Package['php5-cli'],
  }

  package {'php5-common':
    ensure => present,
    require => [File['/etc/php5/cli/php.ini'], File['/etc/php5/conf.d']],
  }
  ->

  package {['php5-cli', 'php5-dev', 'libpcre3-dev']:
    ensure => present,
  }
}
