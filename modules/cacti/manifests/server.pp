class cacti::server (
  $ipPrivateNetwork = $cacti::params::ipPrivateNetwork,
  $dbName           = $cacti::params::dbName,
  $dbUser           = $cacti::params::dbUser,
  $dbPassword       = $cacti::params::dbPassword,
  $dbSenseUser      = $cacti::params::dbSenseUser,
  $dbSensePassword  = $cacti::params::dbSensePassword,
  $sshPublicKey     = $cacti::params::sshPublicKey,
  $storageLvmName   = $cacti::params::storageLvmName,
  $username         = $cacti::params::username,
  $groupname        = $cacti::params::groupname
) inherits cacti::params {

  validate_string($username)
  validate_string($groupname)

  include 'cacti'
  require 'snmp'
  require 'php5::extension::snmp'

  package {'cacti':
    ensure => present,
  }
}
