node default {

  class { 'screenconnect':
    account => 'cargomedia',
    server  => 'myInstanceServer.screenconnect.com',
    key     => 'mySecretKey',
  }

}
