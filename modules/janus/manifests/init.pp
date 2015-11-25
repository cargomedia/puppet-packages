class janus (
  $version = $janus::version::main,
  $bind_address = '127.0.0.1',
  $log_file = '/var/log/janus/janus.log',
  $token_auth = 'no',
  $api_secret = 'cantanapoli',
  $stun_server = undef,
  $stun_port = 3478,
  $turn_server = undef,
  $turn_port = 3479,
  $turn_type = 'udp',
  $turn_user = 'myuser',
  $turn_pwd = 'mypassword',
  $turn_rest_api = undef,
  $turn_rest_api_key = undef
) inherits janus::version {

  include 'janus::service'
  require 'logrotate'

  require 'git'
  require 'build::automake'
  require 'build::libtool'
  class { 'janus::deps::libsrtp': version => $janus::version::srtp, }
  class { 'janus::deps::libusrsctp': version => $janus::version::usrsctp, }
  class { 'janus::deps::libwebsockets':
    version => $janus::version::websockets,
    version_file_name => $janus::version::websockets_version_filename,
  }

  include 'janus::transport::http'
  include 'janus::transport::websockets'

  user { 'janus':
    ensure => present,
    system => true,
  }

  package { [
    'libmicrohttpd-dev',
    'libjansson-dev',
    'libnice-dev',
    'libssl-dev',
    'libsofia-sip-ua-dev',
    'libglib2.0-dev',
    'libopus-dev',
    'libogg-dev',
    'libini-config-dev',
    'libcollection-dev',
    'libavutil-dev',
    'libavcodec-dev',
    'libavformat-dev',
    'gengetopt',]: }
  ->

  git::repository { 'janus-gateway':
    remote      => 'https://github.com/meetecho/janus-gateway.git',
    directory   => '/opt/src/janus',
    revision    => $janus::version::main,
  }
  ~>

  helper::script { 'install janus':
    content      => template("${module_name}/install.sh"),
    refresh_only => true,
    timeout      => 900,
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

  file { '/etc/janus':
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

  sysvinit::script { 'janus':
    content           => template("${module_name}/init.sh"),
    require           => [User['janus']],
  }

}
