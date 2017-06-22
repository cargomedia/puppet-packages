node default {

  mongodb::core::mongod { 'server':
    version => '3.2',
    port => 28017
  }

}
