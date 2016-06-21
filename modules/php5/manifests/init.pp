class php5 {

  require 'apt'

  file { '/etc/php5':
    ensure => directory,
    owner  => '0',
    group  => '0',
    mode   => '0755',
  }

  file { '/etc/php5/conf.d':
    ensure => directory,
    owner  => '0',
    group  => '0',
    mode   => '0755',
  }

  file { '/etc/php5/cli':
    ensure => directory,
    owner  => '0',
    group  => '0',
    mode   => '0755',
  }

  file { '/var/log/php':
    ensure => directory,
    owner  => '0',
    group  => '0',
    mode   => '0755',
  }

  logrotate::entry { $module_name:
    path    => '/var/log/php/error.log',
  }

  php5::config { '/etc/php5/cli/php.ini':
    memory_limit   => '8G',
    display_errors => true,
    before         => Package['php5-cli'],
  }

  package { 'php5-common':
    ensure   => present,
    provider => 'apt',
    require  => [File['/etc/php5/cli/php.ini'], File['/etc/php5/conf.d']],
  }
  ->

  package { ['php5-cli', 'php5-dev', 'libpcre3-dev']:
    ensure   => present,
    provider => 'apt',
  }
  ->

  exec { '/usr/lib/php5/extensions':
    command  => 'ln -s $(php -r "echo ini_get(\"extension_dir\");") /usr/lib/php5/extensions',
    provider => shell,
    creates  => '/usr/lib/php5/extensions',
    path     => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
  }
}
