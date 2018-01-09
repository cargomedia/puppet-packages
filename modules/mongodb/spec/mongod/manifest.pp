node default {

  mongodb::core::mongod { 'server':
    version => '3.4',
    port => 28017
  }

}
