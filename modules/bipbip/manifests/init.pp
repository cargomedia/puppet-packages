class bipbip (
  $api_key = undef,
  $version = 'latest',
  $frequency = 15,
  $tags = $::facts['copperegg_tags'],
  $log_level = 'INFO',
){

  class { 'bipbip::gem':
    version => $version,
    notify  => Daemon['bipbip'],
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
    notify  => Daemon['bipbip'],
  }

  daemon { 'bipbip':
    binary           => '/usr/local/bin/bipbip',
    args             => '-c /etc/bipbip/config.yml',
    user             => 'bipbip',
    oom_score_adjust => -1000,
    require          => [Class['bipbip::gem'], File['/etc/bipbip/config.yml']],
  }

  Bipbip::Entry <||>
}
