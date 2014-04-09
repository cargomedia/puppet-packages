class mongo::mongos (
  $config_servers,
  $version = '2.6.0',
  $port = 27017,
  $bind_ip = '127.0.0.1',
  $fork = false,
  $log_dir = '/var/log/mongodb',
  $log_append = true,
  $options = []
){

  include 'mongo'

  file {
    '/etc/mongos.conf':
      ensure  => file,
      content => template('mongo/mongos/conf'),
      mode    => '0755',
      owner   => 'mongodb',
      group   => 'mongodb',
      notify  => Service['mongos'],
      require => Package['mongodb-org-mongos'];

    '/etc/init.d/mongos':
      ensure  => file,
      content => template('mongo/mongos/init'),
      mode    => '0755',
      owner   => 'mongodb',
      group   => 'mongodb',
      notify  => Service['mongos'],
      require => Package['mongodb-org-mongos'];
  }

  package {'mongodb-org-mongos':
    ensure  => $version,
    require => Class['mongo'],
    before  => Service['mongos'],
  }
  ->

  service {'mongos':
    enable      => true,
    hasstatus   => true,
    hasrestart  => true,
    require     => File['/etc/mongos.conf', '/etc/init.d/mongos'],
  }

  @monit::entry {'mongos':
    content => template('mongo/mongos/monit'),
    require => Service['mongos'],
  }
}
