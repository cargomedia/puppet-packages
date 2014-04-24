node default {

  mongodb::core::mongod {'server':
    port => 28017
  }

}
