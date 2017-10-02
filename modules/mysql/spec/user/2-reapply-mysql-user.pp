node default {

  require 'mysql::server'

  mysql::user { 'bar@localhost': }
}
