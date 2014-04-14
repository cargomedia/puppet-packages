node default {

  include 'monit'

  mongodb::core::mongod {'server':
    port => 28017
  }

}
