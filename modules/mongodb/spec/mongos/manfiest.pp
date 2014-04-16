node default {

  include 'monit'

  class {'mongodb::role::config-server': }

  mongodb::core::mongos {'router':
    config_servers => ['127.0.0.1:27019'],
  }

}
