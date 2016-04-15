node default {

  require 'postgresql::server'

  postgresql::server::role{ 'alice':
    password => 'pass1',
  }

  postgresql::server::database{ 'foo':
  }

  postgresql::server::database{ 'bar':
    owner => 'alice',
  }

}
