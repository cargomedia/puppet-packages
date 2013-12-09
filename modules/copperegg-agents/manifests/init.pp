class copperegg-agents (
  $api_key = 'mykey',
  $frequency = 5,
  $services = {}
){

  $config = {
    'loglevel' => 'INFO',
    'copperegg' => {
      'api_key' => $api_key,
      'frequency' => $frequency,
    },
    'services' => $services,
  }

  package {'libsasl2-dev':
    ensure => present
  }
  ->

  ruby::gem {'copperegg_agents':
    ensure => present,
  }
  ->

  file {'/etc/copperegg-agents.yml':
    ensure => file,
    content => hash_to_yml($config),
  }

  file {'/etc/init.d/copperegg-agents':
    ensure => file,
    content => template('copperegg-agents/init.sh'),
    owner => '0',
    group => '0',
    mode => '0755',
    notify => Service['copperegg-agents'],
  }
  ~>

  exec {'update-rc.d copperegg-agents defaults':
    path => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
    refreshonly => true,
  }

  service {'copperegg-agents':
  }

}