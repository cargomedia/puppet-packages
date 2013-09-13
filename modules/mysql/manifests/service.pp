class mysql::service {

  require 'mysql::server'

  service {'mysql':}
}
