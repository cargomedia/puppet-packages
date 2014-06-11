class mongodb::role::router (
  $port = 27017,
  $bind_ip = '0.0.0.0',
  $hostname = 'localhost',
  $config_servers,
  $options = {}
) {

  mongodb::core::mongos {'router':
    config_servers => $config_servers,
    port => $port,
    bind_ip => $bind_ip,
    options => $options,
  }

}
