class mongo::mongod (
  $version = '2.6.0',
  $port = 27017,
  $bind_ip = '127.0.0.1',
  $user = 'mongodb',
  $group = 'mongodb',
  $log_dir = '/var/log/mongodb',
  $db_dir = '/var/lib',
  $options = []
) {

  include 'mongo'

  user {$user:
    ensure => present,
    system => true,
  }

  file {
    "/etc/mongod.conf":
      ensure  => file,
      content => template('mongo/mongod/conf'),
      mode    => '0755',
      owner   => $user,
      group   => $group,
      notify  => Service["mongod"],
      require => Package['mongodb-org-server'];

    "/etc/init.d/mongod":
      ensure  => file,
      content => template('mongo/mongod/init'),
      mode    => '0755',
      owner   => $user,
      group   => $group,
      notify  => Service["mongod"],
      require => Package['mongodb-org-server'];
  }

  package {'mongodb-org-server':
    ensure  => $version,
    require => Class['mongo'],
    before  => Service["mongod"]
  }

  service {"mongod": }

  class {'mongo::client':
    version => $version,
  }

  @monit::entry {"mongod":
    content => template('mongo/mongod/monit'),
    require => Service["mongod"],
  }

}
