node default {

  include 'monit'

  class {'mongo::mongod':
    version => '2.6.0',
  }

}
