node default {

  mongodb::core::mongod {'config':
    config_server => true,
    port => 27019
  }
  ->

  mongodb::core::mongos {'router':
    config_servers => ['127.0.0.1:27019']
  }

}
