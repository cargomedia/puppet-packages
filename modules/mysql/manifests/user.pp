define mysql::user ($password) {

  require 'mysql::client'

  database_user {$name:
    ensure => present,
    password_hash => mysql_password($password),
    provider => mysql,
    require => Service['mysql'],
  }
}
