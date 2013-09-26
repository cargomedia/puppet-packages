class cacti::server (
  $host       = $cacti::params::host,
  $dbname     = $cacti::params::dbname,
  $dbuser     = $cacti::params::dbuser,
  $dbpassword = $cacti::params::dbpassword,
  $username   = $cacti::params::username,
  $groupname  = $cacti::params::groupname
) inherits cacti::params {

  validate_string($username)
  validate_string($groupname)

  incluse 'cacti'

  require 'snmp'
  require 'php5::extension::snmp'

  package {"cacti":
    ensure => present,
  }
}
