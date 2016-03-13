class mongodb::role::config (
  $port = 27019,
  $bind_ip = '0.0.0.0',
  $hostname = 'localhost',
  $options = { },
  $auth_key = undef,
  $monitoring_credentials = { },
) {

  mongodb::core::mongod { 'config':
    config_server          => true,
    port                   => $port,
    bind_ip                => $bind_ip,
    options                => $options,
    auth_key               => $auth_key,
    monitoring_credentials => $monitoring_credentials,
  }

}
