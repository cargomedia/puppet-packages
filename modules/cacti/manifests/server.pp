class cacti::server (
  $hostname     = $cacti::params::hostname,
  $port         = $cacti::params::port,
  $port_ssl     = $cacti::params::port_ssl,
  $db_host      = $cacti::params::db_host,
  $db_port      = $cacti::params::db_port,
  $db_name      = $cacti::params::db_name,
  $db_user      = $cacti::params::db_user,
  $db_password  = $cacti::params::db_password,
  $ssh_private  = $cacti::params::ssh_private,
  $ssl_cert     = $cacti::params::ssl_pem,
  $htpasswd     = $cacti::params::htpasswd
) inherits cacti::params {

  require 'snmp'
  require 'cacti'
  require 'apache2::mod::ssl'
  require 'php5::extension::snmp'

  class {'cacti::package':
  }

  class {'cacti::helper::mysql-user':
    host      => $db_host,
    user      => $db_user,
    password  => $db_password,
    require   => Class['cacti::package'],
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
    content => $ssh_private,
    mode    => '0600',
    owner   => 'www-data',
    require => Class['cacti::package'],
  }

  file {'/etc/apache2/ssl/cacti.pem':
    ensure  => file,
    content => $ssl_cert,
    require => Class['cacti::package', 'apache2::mod::ssl'],
  }

  file {'/etc/apache2/conf.d/cacti.conf':
    ensure  => file,
    content => template('cacti/vhost'),
    require => Class['cacti::package'],
  }

}
