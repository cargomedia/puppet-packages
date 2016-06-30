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
        before  =>  Daemon[$instance_name],
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
      before  =>  Daemon[$instance_name],
      notify  => Service[$instance_name];
  }

  daemon { $instance_name:
    binary          => "/usr/bin/${daemon}",
    args            => "--config /etc/mongodb/${instance_name}.conf",
    user            => 'mongodb',
    limit_nofile    => 64000,
    limit_fsize     => 'unlimited',
    limit_cpu       => 'unlimited',
    limit_as        => 'unlimited',
    limit_rss       => 'unlimited',
    limit_nproc     => 32000,
    stop_timeout    => 10,
    start_on_create => false,
  }
  ~>

  exec { "Start of ${instance_name}":
    command     => "systemctl start ${instance_name}",
    path        => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
    unless      => "systemctl status ${instance_name}",
    refreshonly => true,
  }
  ~>

  exec { "wait for ${instance_name} up":
    command     => "while ! (mongo --quiet --port ${port} --eval 'db.getMongo()'); do sleep 0.5; done",
    provider    => shell,
    timeout     => 300, # Might take long due to journal file preallocation
    refreshonly => true,
  }

  $hostName = $bind_ip? { undef => 'localhost', default => $bind_ip }
  @bipbip::entry { $instance_name:
    plugin  => 'mongodb',
    options => {
      'hostname' => $hostName,
      'port'     => $port,
      'user'     => $monitoring_credentials['user'],
      'password' => $monitoring_credentials['password'],
    }
  }

  logrotate::entry { $instance_name:
    path              => "/var/log/mongodb/${instance_name}.log",
    rotation_newfile  => 'create',
    postrotate_script => "kill -USR1 $(cat /var/run/${instance_name}.pid)",
  }
}
