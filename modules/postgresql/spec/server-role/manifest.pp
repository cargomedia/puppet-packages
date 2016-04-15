node default {

  require 'postgresql::server'

  postgresql::server::role{ 'foo':
    password => 'pass1',
  }

  postgresql::server::role{ 'bar':
    password => 'pass2',
  }

}
