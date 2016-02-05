node default {

  mongodb::core::mongod { 'server':
    port => 27017,
    auth => true,
  }
}
