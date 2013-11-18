class cacti::mysql::user (
  $dbHost           = $cacti::params::dbHost,
  $dbSenseUser      = $cacti::params::dbSenseUser,
  $dbSensePassword  = $cacti::params::dbSensePassword
) inherits cacti::params {

  mysql::user {"${dbSenseUser}@${dbHost}":
    password => $dbSensePassword,
  }
}
