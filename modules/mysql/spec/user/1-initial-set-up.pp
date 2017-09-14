node default {

  require 'mysql::server'

  mysql::user { 'foo@localhost':
    password => 'mypass',
  }

  mysql::user { 'bar@localhost': }

  exec { 'set an unmanaged password for user bar':
    command  => 'mysql -u bar -e \'set password=PASSWORD("foo");\'',
    provider => shell,
    require => Mysql::User['bar@localhost'],
  }
}
