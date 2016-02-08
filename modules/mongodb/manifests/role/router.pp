class mongodb::role::router (
  $port = 27017,
  $bind_ip = '0.0.0.0',
  $hostname = 'localhost',
  $config_servers,
  $options = { },
  $auth_key = undef,
  $monitoring_credentials = { },
) {

  mongodb::core::mongos { 'router':
    config_servers         => $config_servers,
    port                   => $port,
    bind_ip                => $bind_ip,
    options                => $options,
    auth_key               => $auth_key,
    monitoring_credentials => $monitoring_credentials,
  }

}
