class revive (
  $host,
  $certificatePem,
  $certificateKey,
  $certificateCa = undef,
  $version = '3.0.2',
  $dbName = 'revive',
  $dbUser = 'revive',
  $dbPassword = 'revive'
) {

  require 'php5'
  require 'php5::apache2'
  require 'php5::extension::apc'
  require 'php5::extension::mysql'
  require 'php5::extension::gd'
  require 'openssl'
  require 'apache2::mod::ssl'
  require 'mysql::server'
  require 'rsync'

  helper::script {'install revive':
    content => template('revive/install.sh'),
    unless => "grep -w \"define('VERSION', '${version}')\" /var/revive/constants.php",
    require => Class['rsync'],
  }

  file {"/etc/apache2/ssl/${host}.pem":
    ensure => present,
    content => $certificatePem,
    group => 'www-data',
    owner => 'www-data',
    mode => '0644',
    require => Class['apache2::mod::ssl'],
    before => Apache2::Vhost[$host],
  }

  file {"/etc/apache2/ssl/${host}.key":
    ensure => present,
    content => $certificateKey,
    group => 'www-data',
    owner => 'www-data',
    mode => '0644',
    require => Class['apache2::mod::ssl'],
    before => Apache2::Vhost[$host],
  }

  if $certificateCa {
    apache2::ssl-ca {$host:
      content => $certificateCa,
      before => Apache2::Vhost[$host],
    }
  }

  file {'/var/revive/www/delivery/ajs-proxy.php':
    ensure => present,
    content => template('revive/ajs-proxy.php'),
    group => 'www-data',
    owner => 'www-data',
    mode => '0644',
    require => Helper::Script['install revive'],
  }

  mysql::user {"${dbUser}@localhost":
    password => $dbPassword,
  }

  mysql::database {$dbName:
    user => "${dbUser}@localhost",
  }

  apache2::vhost {$host:
    content => template('revive/vhost'),
  }
}
