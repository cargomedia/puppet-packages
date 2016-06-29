class mongodb::core::mongos_upgrade {

  require 'mongodb'

  $daemon = 'mongos'
  $instance_name = "${daemon}_${name}"

  exec { 'Upgrade config db schema':
    command     => "while ! (mongos --upgrade --config /etc/mongodb/${instance_name}.conf); do sleep 0.5; done",
    provider    => shell,
    timeout     => 60, # Might take long due to journal file preallocation
    refreshonly => true,
  }
}
