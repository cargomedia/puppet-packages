class coturn (
  $realm,
  $port = 3478,
  $port_alt = 0,
  $listening_ip = [],
  $relay_ip = [],
  $external_ip = [],
  $no_multicast_peers = true,
  $relay_port_min = 49152,
  $relay_port_max = 65535,
  $mice = true,
  $static_user_accounts = [],
  $lt_cred_mech = true,
  $ufw_app_profile = undef,
) {

  require 'apt'
  require 'apt::source::cargomedia'

  user { 'turnserver':
    ensure => present,
    system => true,
  }
  ->

  file {
    '/var/log/coturn':
      ensure => directory,
      owner  => 'turnserver',
      group  => 'turnserver',
      mode   => '0644';
    '/etc/coturn':
      ensure => directory,
      owner  => '0',
      group  => '0',
      mode   => '0644';
    '/var/log/coturn/turnserver.log':
      ensure => file,
      owner  => 'turnserver',
      group  => 'turnserver',
      mode   => '0644';
    '/etc/coturn/turnserver.conf':
      ensure  => file,
      content => template("${module_name}/config"),
      owner   => '0',
      group   => '0',
      mode    => '0644',
      notify  => Daemon['coturn'];
  }

  logrotate::entry { $module_name:
    path    => '/var/log/coturn/*.log',
  }

  @bipbip::entry { 'coturn':
    plugin  => 'coturn',
    options => {
      'hostname' => 'localhost',
      'port'     => 5766,
    }
  }

  package { 'coturn':
    provider => 'apt',
  }
  ->

  daemon { 'coturn':
    binary       => '/usr/bin/turnserver',
    args         => '-c /etc/coturn/turnserver.conf -v -l /var/log/coturn/turnserver.log --simple-log --no-dtls --no-tls --no-stdout-log',
    user         => 'turnserver',
    limit_nofile => 65536,
    require      => [ File['/etc/coturn/turnserver.conf'], File['/var/log/coturn/turnserver.log'] ]
  }

  if ($port_alt == 0) {
    $port_alt_real = $port + 1
  } else {
    $port_alt_real = $port_alt
  }

  $ufw_default = "${port},${port_alt_real},${relay_port_min}:${relay_port_max}/tcp|${port},${port_alt_real},${relay_port_min}:${relay_port_max}/udp"

  $ufw_rule = $ufw_app_profile ? {
    undef => $ufw_default,
    default => $ufw_app_profile,
  }

  @ufw::application { 'turnserver':
    app_ports       => $ufw_rule,
  }
}
