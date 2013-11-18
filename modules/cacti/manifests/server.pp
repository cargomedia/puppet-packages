class cacti::server (
  $host             = $cacti::params::host,
  $domain           = $cacti::params::domain,
  $ipPrivateNetwork = $cacti::params::ipPrivateNetwork,
  $dbHost           = $cacti::params::dbHost,
  $dbPort           = $cacti::params::dbPort,
  $dbName           = $cacti::params::dbName,
  $dbUser           = $cacti::params::dbUser,
  $dbPassword       = $cacti::params::dbPassword,
  $dbSenseUser      = $cacti::params::dbSenseUser,
  $dbSensePassword  = $cacti::params::dbSensePassword,
  $sshPublicKey     = $cacti::params::sshPublicKey,
  $sslPem           = $cacti::params::sslPem,
  $username         = $cacti::params::username,
  $groupname        = $cacti::params::groupname
) inherits cacti::params {

  require 'snmp'
  require 'php5::extension::snmp'
  require 'php5::extension::apc'

  include 'cacti'
  include 'apache2::mod::ssl'

  class {'cacti::package': }

  class {'cacti::mysql::user':
    dbHost          => $dbHost,
    dbSenseUser     => $dbSenseUser,
    dbSensePassword => $dbSensePassword,
    require         => [Class['cacti::package']],
  }

  file {'/etc/cacti/debian.php':
    ensure => file,
    content => template('cacti/etc/debian.php'),
    require => [Class['cacti::package']],
  }

  file {'/etc/cacti/htpasswd':
    ensure => file,
    content => template('cacti/etc/htpasswd'),
    require => [Class['cacti::package']],
  }

  file {'/etc/cacti/id_rsa':
    ensure => file,
    content => template('cacti/etc/id_rsa'),
    require => [Class['cacti::package']],
  }

  file {'/etc/apache2/ssl/cacti.pem':
    ensure => file,
    content => $sslPem,
    require => Class['cacti::package', 'apache2::mod::ssl'],
  }

  file {'/etc/apache2/conf.d/cacti.conf':
    ensure => file,
    content => template('cacti/vhost'),
    require => [Class['cacti::package']],
  }

}
