class cacti::mysql::users (
  $dbSenseUser   = $cacti::params::dbSenseUser,
  $dbSensePassword  = $cacti::params::dbSensePassword
) inherits cacti::params {

  mysql::user {$dbSenseUser:
    password => $dbSensePassword,
  }
}
