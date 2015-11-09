class janus (
  $log_file = '/var/log/janus/janus.log',
){

  include 'janus::service'
  require 'logrotate'

  require 'git'
  require 'build::automake'
  require 'build::libtool'
  require 'janus::deps::libsrtp'
  require 'janus::deps::libusrsctp'
  require 'janus::deps::libwebsockets'

  user { 'janus':
    ensure => present,
    system => true,
  }

  package { [
    'libmicrohttpd-dev',
    'libjansson-dev',
    'libnice-dev',
    'libssl-dev',
    'libsrtp-dev',
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

  helper::script { 'install janus':
    content => template("${module_name}/install.sh"),
    unless  => false,
    timeout => 900,
  }


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
