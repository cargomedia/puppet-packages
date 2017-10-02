define mysql::user ($password=undef) {

  require 'mysql::client'

  if $password == undef {
    database_user { $name:
      ensure        => present,
      provider      => mysql,
      require       => Service['mysql'],
    }
  } else {
    database_user { $name:
      ensure        => present,
      password_hash => mysql_password($password),
      provider      => mysql,
      require       => Service['mysql'],
    }
  }
}
