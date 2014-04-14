define mongodb::core::mongos (
  $config_servers,
  $port = 27017,
  $bind_ip = '127.0.0.1',
  $fork = false,
  $log_dir = '/var/log/mongodb',
  $log_append = true,
  $options = []
){

  include 'mongodb'
  include 'mongodb::install'

  $daemon = 'mongos'
  $instance_name = "${daemon}_${name}"

  file {
    "/etc/${instance_name}.conf":
      ensure  => file,
      content => template('mongodb/mongos/conf'),
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
    enable      => true,
    hasrestart  => true,
    hasstatus   => true,
  }

  @monit::entry {$instance_name:
    content => template('mongodb/monit'),
    require => Service[$instance_name],
  }
}
