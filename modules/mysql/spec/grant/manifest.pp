node default {

  require 'mysql::server'

  mysql::database {'bar':
  }

  mysql::user {'foo@localhost':
    password => 'mypassword',
  }

  mysql::grant {'foo@localhost/bar':
    privileges => ['select_priv']
  }
}
