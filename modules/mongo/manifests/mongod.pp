class mongo::mongod (
  $version = '2.6.0',
  $port = 27017,
  $bind_ip = '127.0.0.1',
  $repl_set = '',
  $config_server = false,
  $shard_server = false,
  $rest = true,
  $fork = false,
  $log_dir = '/var/log/mongodb',
  $db_dir = '/var/lib',
  $options = []
) {

  include 'mongo'

  file {
    '/etc/mongod.conf':
      ensure  => file,
      content => template('mongo/mongod/conf'),
      mode    => '0755',
      owner   => 'mongodb',
      group   => 'mongodb',
      require => Service['mongod'];

    '/etc/init.d/mongod':
      ensure  => file,
      content => template('mongo/mongod/init'),
      mode    => '0755',
      owner   => 'mongodb',
      group   => 'mongodb',
      require => Service['mongod'];
  }

  package {'mongodb-org-server':
    ensure  => $version,
    require => Class['mongo'],
  }
  ->

  service {'mongod': }

  class {'mongo::client':
    version => $version,
  }

  @monit::entry {'mongod':
    content => template('mongo/mongod/monit'),
    require => Service['mongod'],
  }

}
