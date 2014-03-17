node default {



  class {'puppet::master':
    server_engine => 'passenger',
  }

}
