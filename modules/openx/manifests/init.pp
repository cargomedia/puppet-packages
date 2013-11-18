class openx (
  $host,
  $certificatePem,
  $certificateKey,
  $certificateCa = undef,
  $version = '2.8.11',
  $dbName = 'openx',
  $dbUser = 'openx',
  $dbPassword = 'openx'
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

  helper::script {'install openx':
    content => template('openx/install.sh'),
    unless => "test -e /var/openx/README.txt && grep -q 'Version ${version}$' /var/openx/README.txt",
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

  file {'/var/openx/www/delivery/ajs-proxy.php':
    ensure => present,
    content => template('openx/ajs-proxy.php'),
    group => 'www-data',
    owner => 'www-data',
    mode => '0644',
    require => Helper::Script['install openx'],
  }

  mysql::user {"${dbUser}@localhost":
    password => $dbPassword,
  }

  mysql::database {$dbName:
    user => "${dbUser}@localhost",
  }

  apache2::vhost {$host:
    content => template('openx/vhost'),
  }
}
