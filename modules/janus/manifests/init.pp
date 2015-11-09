class janus (
  $log_file = '/var/log/janus/janus.log',
){

  require 'logrotate'
  include 'janus::service'
  require 'janus::deps::libsrtp'
  require 'janus::deps::libusrsctp'
  require 'janus::deps::libwebsockets'

  package { ['libmicrohttpd-dev', 'libjansson-dev', 'libnice-dev',
    'libssl-dev', 'libsrtp-dev', 'libsofia-sip-ua-dev', 'libglib2.0-dev',
    'libopus-dev', 'libogg-dev', 'libini-config-dev', 'libcollection-dev',
    'libavutil-dev', 'libavcodec-dev', 'libavformat-dev','pkg-config', 'gengetopt',
    'libcurl4-openssl-dev', 'libtool', 'automake', 'cmake']: }

  file { '/var/log/janus':
    ensure => directory,
    owner  => 'janus',
    group  => 'janus',
    mode   => '0755',
  }
  ->

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

  sysvinit::script { 'janus':
    content           => template("${module_name}/init.sh"),
    require           => [User['janus']],
  }
}
