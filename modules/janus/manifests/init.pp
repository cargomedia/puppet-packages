class janus (
  $bind_address = '127.0.0.1',
  $log_file = '/var/log/janus/janus.log',
  $token_auth = 'no',
  $api_secret = undef,
  $rtp_port_range_min = 20000,
  $rtp_port_range_max = 25000,
  $stun_server = undef,
  $stun_port = 3478,
  $turn_server = undef,
  $turn_port = 3479,
  $turn_type = 'udp',
  $turn_user = 'myuser',
  $turn_pwd = 'mypassword',
  $turn_rest_api = undef,
  $turn_rest_api_key = undef
) {

  require 'apt'
  require 'apt::source::cargomedia'
  include 'janus::service'

  include 'janus::transport::http'
  include 'janus::transport::websockets'

  user { 'janus':
    ensure => present,
    system => true,
  }

  package { 'janus':
    provider => 'apt',
  }
  ->

  file { '/etc/ssl/private/ssl-cert-snakeoil.key':
    ensure => file,
    mode   => '0644',
  }

  file { '/var/log/janus':
    ensure => directory,
    owner  => 'janus',
    group  => 'janus',
    mode   => '0755',
  }

  file { '/var/log/janus/janus.log':
    ensure => file,
    owner  => 'janus',
    group  => 'janus',
    mode   => '0644',
  }
  ->

  logrotate::entry{ $module_name:
    content => template("${module_name}/logrotate"),
  }

  file { ['/etc/janus', '/etc/janus/ssl']:
    ensure => directory,
    owner  => '0',
    group  => '0',
    mode   => '0755',
  }

  file { '/etc/janus/janus.cfg':
    ensure  => file,
    content => template("${module_name}/config"),
    owner   => '0',
    group   => '0',
    mode    => '0644',
    notify  => Service['janus'],
  }

  file { '/var/lib/janus':
    ensure => directory,
    owner  => 'janus',
    group  => 'janus',
    mode   => '0755',
  }

  file { '/var/lib/janus/recordings':
    ensure => directory,
    owner  => 'janus',
    group  => 'janus',
    mode   => '0755',
  }

  file { '/var/lib/janus/jobs':
    ensure => directory,
    owner  => 'janus',
    group  => 'janus',
    mode   => '0755',
  }

  file {'/etc/janus/ssl/cert.pem':
    ensure => file,
    content => template("${module_name}/ssl-cert-janus-snakeoil.pem"),
    owner  => 'janus',
    group  => 'janus',
    mode   => '0755',
  }

  file {'/etc/janus/ssl/cert.key':
    ensure => file,
    content => template("${module_name}/ssl-cert-janus-snakeoil.key"),
    owner  => 'janus',
    group  => 'janus',
    mode   => '0755',
  }

}
