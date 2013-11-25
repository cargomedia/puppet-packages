class cacti::server (
  $domain           = $cacti::params::domain,
  $deployDir        = $cacti::params::deployDir,
  $dbHost           = $cacti::params::dbHost,
  $dbPort           = $cacti::params::dbPort,
  $dbName           = $cacti::params::dbName,
  $dbUser           = $cacti::params::dbUser,
  $dbPassword       = $cacti::params::dbPassword,
  $dbSenseUser      = $cacti::params::dbSenseUser,
  $dbSensePassword  = $cacti::params::dbSensePassword,
  $htpasswd         = $cacti::params::htpasswd,
  $sshPrivateKey    = $cacti::params::sshPrivateKey,
  $sslPem           = $cacti::params::sslPem
) inherits cacti::params {

  require 'snmp'
  require 'cacti'
  require 'apache2::mod::ssl'
  require 'php5::extension::snmp'

  class {'cacti::package': }

  class {'cacti::helper::mysql-user':
    host      => $dbHost,
    user      => $dbUser,
    password  => $dbPassword,
    require   => Class['cacti::package'],
  }

  class {'cacti::resource::bootstrap':
    deployDir       => $deployDir,
    dbSenseUser     => $dbSenseUser,
    dbSensePassword => $dbSensePassword,
    require         => Class['cacti::package'],
  }

  file {'/etc/cacti/debian.php':
    ensure  => file,
    content => template('cacti/etc/debian.php'),
    require => Class['cacti::package'],
  }

  file {'/etc/cacti/htpasswd':
    ensure  => file,
    content => $htpasswd,
    require => Class['cacti::package'],
  }

  file {'/etc/cacti/id_rsa':
    ensure  => file,
    content => $sshPrivateKey,
    mode    => '0600',
    owner   => 'www-data',
    require => Class['cacti::package'],
  }

  file {'/etc/apache2/ssl/cacti.pem':
    ensure  => file,
    content => $sslPem,
    require => Class['cacti::package', 'apache2::mod::ssl'],
  }

  file {'/etc/apache2/conf.d/cacti.conf':
    ensure  => file,
    content => template('cacti/vhost'),
    require => Class['cacti::package'],
  }

}
