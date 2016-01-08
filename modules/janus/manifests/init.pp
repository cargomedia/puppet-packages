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
  $config_file = '/etc/janus/janus.cfg',
  $plugin_config_dir = '/etc/janus',
  $turn_rest_api = undef,
  $turn_rest_api_key = undef,
  $src_version = undef,
) {

  require 'apt'
  require 'apt::source::cargomedia'
  require 'logrotate'

  user { 'janus':
    ensure => present,
    system => true,
  }

  if $src_version {
    class { 'janus::source':
      version => $src_version,
      before  => Daemon['janus'],
      notify  => Service['janus'],
    }
  } else {
    package { 'janus':
      provider => 'apt',
      before   => Daemon['janus'],
      notify   => Service['janus'],
    }
  }

  logrotate::entry{ $module_name:
    content => template("${module_name}/logrotate"),
  }

  file {
    ['/etc/janus', '/etc/janus/ssl']:
      ensure => directory,
      owner  => '0',
      group  => '0',
      mode   => '0644';
    ['/var/lib/janus', '/var/lib/janus/recordings', '/var/lib/janus/jobs']:
      ensure => directory,
      owner  => 'janus',
      group  => 'janus',
      mode   => '0644';
    '/var/log/janus':
      ensure => directory,
      owner  => 'janus',
      group  => 'janus',
      mode   => '0644';
  }
  ->

  file {
    '/var/log/janus/janus.log':
      ensure => file,
      owner  => 'janus',
      group  => 'janus',
      mode   => '0644';
    '/etc/janus/ssl/cert.pem':
      ensure  => file,
      content => template("${module_name}/ssl-cert-janus-snakeoil.pem"),
      owner   => 'janus',
      group   => 'janus',
      mode    => '0644';
    '/etc/janus/ssl/cert.key':
      ensure  => file,
      content => template("${module_name}/ssl-cert-janus-snakeoil.key"),
      owner   => 'janus',
      group   => 'janus',
      mode    => '0640';
    '/etc/janus/janus.cfg':
      ensure   => file,
      content  => template("${module_name}/config"),
      owner    => '0',
      group    => '0',
      mode     => '0644',
      notify   => Service['janus'],
  }
  ->

  daemon { 'janus':
    binary  => '/usr/bin/janus',
    args    => "-o -C ${config_file} -F ${plugin_config_dir} -L ${log_file}",
    user    => 'janus',
    require => [File[$config_file, $plugin_config_dir, $log_file]],
  }
}
