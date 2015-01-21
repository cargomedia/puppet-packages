class pulsar_rest_api (
  $version = '0.1.4',
  $port = 8080,

  $mongodbHost = 'localhost',
  $mongodbPort = 27017,
  $mongodbDb = 'pulsar-rest-api',

  $logDir = '/var/log/pulsar-rest-api',

  $pulsarRepo = undef,
  $pulsarBranch = undef,

  $auth = undef,

  $sslKey = undef,
  $sslPfx = undef,
  $sslCert = undef,
  $sslPassphrase = undef
) {

  require 'nodejs'
  if $mongodbHost == 'localhost' {
    class { 'mongodb::role::standalone':
      hostname => $mongodbHost,
      port     => $mongodbPort,
    }
  }
  include 'pulsar_rest_api::service'

  file { '/etc/pulsar-rest-api':
    ensure => directory,
    owner  => 'pulsar-rest-api',
    group  => '0',
    mode   => '0755',
  }

  file { '/etc/pulsar-rest-api/ssl':
    ensure => directory,
    owner  => 'pulsar-rest-api',
    group  => '0',
    mode   => '0755',
  }

  if $sslKey {
    $sslKeyFile = '/etc/pulsar-rest-api/ssl/cert.key'
    file { $sslKeyFile:
      ensure  => file,
      content => $sslKey,
      owner  => 'pulsar-rest-api',
      group   => '0',
      mode    => '0640',
      before  => File['/etc/init.d/pulsar-rest-api'],
      notify  => Service['pulsar-rest-api'],
    }
  }

  if $sslCert {
    $sslCertFile = '/etc/pulsar-rest-api/ssl/cert.pem'
    file { $sslCertFile:
      ensure  => file,
      content => $sslCert,
      owner  => 'pulsar-rest-api',
      group   => '0',
      mode    => '0640',
      before  => File['/etc/init.d/pulsar-rest-api'],
      notify  => Service['pulsar-rest-api'],
    }
  }

  if $sslPfx {
    $sslPfxFile = '/etc/pulsar-rest-api/ssl/cert.pfx'
    file { $sslPfxFile:
      ensure  => file,
      content => $sslPfx,
      owner  => 'pulsar-rest-api',
      group   => '0',
      mode    => '0640',
      before  => File['/etc/init.d/pulsar-rest-api'],
      notify  => Service['pulsar-rest-api'],
    }
  }

  if $sslPassphrase {
    $sslPassphraseFile = '/etc/pulsar-rest-api/ssl/passphrase'
    file { $sslPassphraseFile:
      ensure  => file,
      content => $sslPassphrase,
      owner   => '0',
      group   => '0',
      mode    => '0640',
      before  => File['/etc/init.d/pulsar-rest-api'],
      notify  => Service['pulsar-rest-api'],
    }
  }

  file { '/etc/pulsar-rest-api/config.yml':
    ensure  => file,
    content => template('pulsar_rest_api/config.yml'),
    owner  => 'pulsar-rest-api',
    group   => '0',
    mode    => '0640',
    before  => File['/etc/init.d/pulsar-rest-api'],
    notify  => Service['pulsar-rest-api'],
  }

  user { 'pulsar-rest-api':
    ensure => present,
    system => true,
  }

  file { $logDir:
    ensure  => directory,
    owner   => 'pulsar-rest-api',
    group   => '0',
    mode    => '0755',
  }

  logrotate::entry{ $module_name:
    content => template("${module_name}/logrotate")
  }

  file { '/etc/init.d/pulsar-rest-api':
    ensure  => file,
    content => template("${module_name}/init.sh"),
    owner   => 'pulsar-rest-api',
    group   => '0',
    mode    => '0755',
    notify  => Service['pulsar-rest-api'],
    before  => Package['pulsar-rest-api'],
  }
  ~>

  exec { 'update-rc.d pulsar-rest-api defaults':
    path        => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
    refreshonly => true,
  }


  package { 'pulsar-rest-api':
    ensure   => $version,
    provider => 'npm',
    require  => Class['nodejs'],
  }

  @monit::entry { 'pulsar-rest-api':
    content => template("${module_name}/monit"),
    require => Service['pulsar-rest-api'],
  }
}
