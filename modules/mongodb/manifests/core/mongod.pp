define mongodb::core::mongod (
  $port = 27017,
  $bind_ip = '127.0.0.1',
  $repl_set = '',
  $config_server = false,
  $shard_server = false,
  $rest = false,
  $fork = false,
  $log_dir = '/var/log/mongodb',
  $db_dir = '/var/lib/mongodb',
  $options = []
) {

  include 'mongodb'
  include 'mongodb::install'

  $daemon = 'mongod'
  $instance_name = "${daemon}_${name}"

  file {
    "${db_dir}/${instance_name}":
      ensure => directory,
      mode    => '0655',
      owner   => 'mongodb',
      group   => 'mongodb',
      require => Class['mongodb::install'];

    "/etc/${instance_name}.conf":
      ensure  => file,
      content => template('mongodb/mongod/conf'),
      mode    => '0755',
      owner   => 'mongodb',
      group   => 'mongodb',
      require => Class['mongodb::install'];

    "/etc/init.d/${instance_name}":
      ensure  => file,
      content => template('mongodb/init'),
      mode    => '0755',
      owner   => 'mongodb',
      group   => 'mongodb',
      require => Class['mongodb::install'];
  }
  ->

  service {$instance_name:
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
  }
  ->

  exec {"update-rc.d ${instance_name} defaults  && /etc/init.d/${instance_name} start":
    path => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
    refreshonly => true,
  }

  @monit::entry {$instance_name:
    content => template('mongodb/monit'),
    require => Service[$instance_name],
  }

}
