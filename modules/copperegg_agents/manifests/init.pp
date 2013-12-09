class copperegg_agents (
  $api_key,
  $services,
  $frequency = 5
){

  require 'ruby::gem::copperegg_agents'

  $config = {
    'loglevel' => 'INFO',
    'copperegg' => {
      'api_key' => $api_key,
      'frequency' => $frequency,
    },
    'services' => $services,
  }

  user {'copperegg_agents':
    ensure => present,
    system => true,
  }
  ->

  file {'/etc/copperegg_agents.yml':
    ensure => file,
    content => hash_to_yml($config),
    owner => '0',
    group => '0',
    mode => '0755',
    notify => Service['copperegg_agents'],
  }
  ->

  file {'/etc/init.d/copperegg_agents':
    ensure => file,
    content => template('copperegg_agents/init.sh'),
    owner => '0',
    group => '0',
    mode => '0755',
    notify => Service['copperegg_agents'],
  }
  ~>

  exec {'update-rc.d copperegg_agents defaults':
    path => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
    refreshonly => true,
  }

  service {'copperegg_agents':
  }

}