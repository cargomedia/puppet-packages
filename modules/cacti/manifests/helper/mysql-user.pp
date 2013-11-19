class cacti::helper::mysql-user ($host, $user, $password) {

  mysql::user {"${user}@${host}":
    password => $password,
  }
}
