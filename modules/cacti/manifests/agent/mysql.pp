class cacti::agent::mysql (
  $user = 'cacti-sense',
  $password  = 'password',
  $db_grant = '%'
) {

  mysql::user {"${user}@%":
    password => $password,
  }

  mysql::database {$db_grant:
    user => "${user}@%",
  }

}