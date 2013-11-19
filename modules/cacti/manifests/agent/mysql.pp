class cacti::agent::mysql (
  $dbHost           = $cacti::params::dbHost,
  $dbSenseUser      = $cacti::params::dbSenseUser,
  $dbSensePassword  = $cacti::params::dbSensePassword
) inherits cacti::params {

  class {'cacti::helper::mysql-user':
    host      => $dbHost,
    user      => $dbSenseUser,
    password  => $dbSensePassword
  }

  class {'cacti::helper::mysql-grant':
    host  => $dbHost,
    user  => $dbSenseUser,
    db    => '%'
  }

}