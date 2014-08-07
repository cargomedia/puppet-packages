define mongodb::core::mongod (
  $port = 27017,
  $bind_ip = undef,
  $repl_set = '',
  $config_server = false,
  $shard_server = false,
  $rest = false,
  $fork = false,
  $options = {}
) {

  require 'mongodb'

  $daemon = 'mongod'
  $instance_name = "${daemon}_${name}"

  file {
    "/var/lib/mongodb/${instance_name}":
      ensure  => directory,
      mode    => '0644',
      owner   => 'mongodb',
      group   => 'mongodb';

    "/etc/mongodb/${instance_name}.conf":
      ensure  => file,
      content => template('mongodb/mongod/conf'),
      mode    => '0644',
      owner   => 'mongodb',
      group   => 'mongodb',
      notify  => Service[$instance_name];

    "/etc/init.d/${instance_name}":
      ensure  => file,
      content => template('mongodb/init'),
      mode    => '0755',
      owner   => 'mongodb',
      group   => 'mongodb',
      notify  => Service[$instance_name];
  }
  ~>

  exec {"/etc/init.d/${instance_name} start":
    path => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
    refreshonly => true,
  }
  ~>

  exec {"wait for ${instance_name} up":
    command => "while ! (mongo --quiet --port ${port} --eval 'db.getMongo()'); do sleep 0.5; done",
    provider => shell,
    timeout => 100,
    refreshonly => true,
  }

  service {$instance_name:
    enable => true,
    hasrestart => false,
  }

  @monit::entry {$instance_name:
    content => template('mongodb/monit'),
    require => Service[$instance_name],
  }

  @bipbip::entry {$instance_name:
    plugin => 'mongodb',
    options => {
      'hostname' => $bind_ip? {undef => 'localhost', default => $bind_ip},
      'port' => $port,
    }
  }
}
