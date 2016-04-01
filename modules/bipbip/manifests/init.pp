class bipbip (
  $api_key = undef,
  $version = 'latest',
  $frequency = 15,
  $tags = $::copperegg_tags,
  $log_file = '/var/log/bipbip/bipbip.log',
  $log_level = 'INFO',
){

  include 'logrotate'

  class { 'bipbip::gem':
    version => $version,
    notify  => Service['bipbip'],
  }

  user { 'bipbip':
    ensure     => present,
    system     => true,
    managehome => true,
    home       => '/home/bipbip',
  }

  file { '/etc/bipbip':
    ensure => directory,
    owner  => '0',
    group  => '0',
    mode   => '0644',
  }

  file { '/etc/bipbip/services.d':
    ensure  => directory,
    owner   => '0',
    group   => '0',
    mode    => '0644',
    purge   => true,
    recurse => true,
  }

  file { '/etc/bipbip/config.yml':
    ensure  => file,
    content => template("${module_name}/config.yml"),
    owner   => '0',
    group   => '0',
    mode    => '0644',
    notify  => Service['bipbip'],
  }

  file {
    '/var/log/bipbip':
      ensure => directory,
      owner  => 'bipbip',
      group  => 'bipbip',
      mode   => '0644';
    '/var/log/bipbip/bipbip.log':
      ensure => file,
      owner  => 'bipbip',
      group  => 'bipbip',
      mode   => '0644',
  }

  logrotate::entry { $module_name:
    path    => '/var/log/bipbip/*.log',
    require => File['/var/log/bipbip'],
  }

  daemon { 'bipbip':
    binary           => '/usr/local/bin/bipbip',
    args             => '-c /etc/bipbip/config.yml',
    user             => 'bipbip',
    oom_score_adjust => -1000,
    require          => [Class['bipbip::gem'], File['/etc/bipbip/config.yml', '/var/log/bipbip/bipbip.log']],
  }

  Bipbip::Entry <||>
}
