node default {

  include 'monit'

  class {'mongo::mongod':
    port => 27019,
    config_server => true,
  }

  class {'mongo::mongos':
    config_servers => ['127.0.0.1:27019'],
    version => '2.6.0',
    require => Class['mongo::mongod']
  }

}
