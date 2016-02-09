class mongodb::role::standalone (
  $port = 27017,
  $bind_ip = '0.0.0.0',
  $hostname = 'localhost',
  $rest = true,
  $auth = false,
  $options = { },
  $monitoring_credentials = { },
) {

  mongodb::core::mongod { 'standalone':
    port                   => $port,
    bind_ip                => $bind_ip,
    rest                   => $rest,
    options                => $options,
    auth                   => $auth,
    monitoring_credentials => $monitoring_credentials,
  }

}
