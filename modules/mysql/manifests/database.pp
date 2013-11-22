define mysql::database ($user = undef) {

  require 'mysql::server'

  database {$name:
    ensure => present,
    provider => mysql,
    require => Service['mysql'],
  }

  if $user {
    database_grant {"${user}/${name}":
    privileges => ['all'],
    provider => 'mysql',
    require => Mysql::User[$user],
    }
  }
}
