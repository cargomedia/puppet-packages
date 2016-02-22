define mongodb::core::mongos (
  $config_servers,
  $port = 27017,
  $bind_ip = undef,
  $fork = false,
  $options = { },
  $auth_key = undef,
  $monitoring_credentials = { },
) {

  require 'mongodb'

  $daemon = 'mongos'
  $instance_name = "${daemon}_${name}"

  if $auth_key {
    $key_file_path = '/var/lib/mongodb/cluster-key-file'
    if !defined(File[$key_file_path]) {
      file { $key_file_path:
        ensure  => file,
        content => $auth_key,
        mode    => '0400',
        owner   => 'mongodb',
        group   => 'mongodb',
        notify  => Service[$instance_name],
      }
    }
  }

  file {
    "/etc/mongodb/${instance_name}.conf":
      ensure  => file,
      content => template("${module_name}/mongos/conf"),
      mode    => '0644',
      owner   => 'mongodb',
      group   => 'mongodb',
      notify  => Service[$instance_name];

    "/etc/init.d/${instance_name}":
      ensure  => file,
      content => template("${module_name}/init"),
      mode    => '0755',
      owner   => 'mongodb',
      group   => 'mongodb',
      notify  => Service[$instance_name];
  }
  ~>

  exec { "/etc/init.d/${instance_name} start":
    path        => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
    refreshonly => true,
  }
  ~>

  exec { "wait for ${instance_name} up":
    command     => "while ! (mongo --quiet --port ${port} --eval 'db.getMongo()'); do sleep 0.5; done",
    provider    => shell,
    timeout     => 100,
    refreshonly => true,
  }

  service { $instance_name:
    enable     => true,
    hasrestart => false,
  }

  @monit::entry { $instance_name:
    content => template("${module_name}/monit"),
    require => Service[$instance_name],
  }

  $hostName = $bind_ip? { undef => 'localhost', default => $bind_ip }
  @bipbip::entry { $instance_name:
    plugin  => 'mongodb',
    options => {
      'hostname' => $hostName,
      'port' => $port,
      'user' => $monitoring_credentials['user'],
      'password' => $monitoring_credentials['password'],
    }
  }

  logrotate::entry{ $instance_name:
    content => template("${module_name}/logrotate")
  }
}
