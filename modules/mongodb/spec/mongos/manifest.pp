node default {

  mongodb::core::mongod {'config':
    port => 27019,
    config_server => true,
  }
  ->

  mongodb::core::mongos {'router':
    port => 27017,
    config_servers => ['127.0.0.1:27019'],
  }

}
