define mongodb::core::mongod (
  $port                   = 27017,
  $bind_ip                = undef,
  $repl_set               = '',
  $config_server          = false,
  $shard_server           = false,
  $rest                   = false,
  $fork                   = false,
  $auth                   = false,
  $options                = { },
  $auth_key               = undef,
  $monitoring_credentials = { },
  $version                = undef,
  $storage_engine         = undef,
) {

  if !defined(Class['mongodb']) {
    class { 'mongodb':
      version => $version
    }
  }

  $daemon = 'mongod'
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
        before  => Daemon[$instance_name],
        notify  => Service[$instance_name],
        require => Class['mongodb'];
      }
    }
  }

  file {
    "/var/lib/mongodb/${instance_name}":
      ensure  => directory,
      mode    => '0644',
      owner   => 'mongodb',
      group   => 'mongodb',
      before  => Daemon[$instance_name],
      require => Class['mongodb'];

    "/etc/mongodb/${instance_name}.conf":
      ensure  => file,
      content => template("${module_name}/mongod/conf"),
      mode    => '0644',
      owner   => 'mongodb',
      group   => 'mongodb',
      before  => Daemon[$instance_name],
      notify  => Service[$instance_name],
      require => Class['mongodb'];
  }

  daemon { $instance_name:
    binary       => "/usr/bin/${daemon}",
    args         => "--config /etc/mongodb/${instance_name}.conf --syslog",
    user         => 'mongodb',
    limit_nofile => 64000,
    limit_fsize  => 'unlimited',
    limit_cpu    => 'unlimited',
    limit_as     => 'unlimited',
    limit_rss    => 'unlimited',
    limit_nproc  => 32000,
    stop_timeout => 10,
    require      => Class['mongodb'],
  }
  ~>

  exec { "wait for ${instance_name} up":
    command     => "while ! (mongo --quiet --port ${port} --eval 'db.getMongo()'); do sleep 0.5; done",
    provider    => shell,
    timeout     => 600, # Might take long due to journal file preallocation
    refreshonly => true,
  }

  $hostName = $bind_ip ? {
    undef   => 'localhost',
    default => $bind_ip
  }

  if has_key($monitoring_credentials, 'user') and has_key($monitoring_credentials, 'password') {
    @bipbip::entry { $instance_name:
      plugin  => 'mongodb',
      options => {
        'hostname' => $hostName,
        'port'     => $port,
        'user'     => $monitoring_credentials['user'],
        'password' => $monitoring_credentials['password'],
      }
    }
  }
}
