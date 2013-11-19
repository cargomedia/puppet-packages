class cacti::helper::mysql-grant ($host, $db, $user) {

  mysql::database {"${db}":
    user => "${user}@${host}"
  }
}