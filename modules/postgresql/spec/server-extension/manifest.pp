node default {

  require 'postgresql::server'

  postgresql::server::database{ 'my-db':
  }

  postgresql::server::extension{ 'pg_trgm':
    database => 'my-db',
  }

}
