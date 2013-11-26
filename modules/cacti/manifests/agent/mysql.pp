class cacti::agent::mysql (
  $db_host            = $cacti::params::db_host,
  $db_sense_user      = $cacti::params::db_sense_user,
  $db_sense_password  = $cacti::params::db_sense_password
) inherits cacti::params {

  class {'cacti::helper::mysql-user':
    host      => $db_host,
    user      => $db_sense_user,
    password  => $db_sense_password
  }

  class {'cacti::helper::mysql-grant':
    host  => $db_host,
    user  => $db_sense_user,
    db    => '%'
  }

}