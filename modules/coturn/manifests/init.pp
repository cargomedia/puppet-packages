class coturn (
  $port = 3478,
  $port_alt = 0,
  $listening_ip = ['127.0.0.1'],
  $relay_ip = [],
  $external_ip = [],
  $no_multicast_peers = true,
  $mice = false,
  $static_user_accounts = [],
  $realm = undef
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
    '/var/log/coturn/turnserver.log':
      ensure => file,
      owner  => 'turnserver',
      group  => 'turnserver',
      mode   => '0644';
    '/etc/default/coturn':
      ensure  => file,
      content => "TURNSERVER_ENABLED=1\n",
      owner   => '0',
      group   => '0',
      mode    => '0644',
      before  => Package['coturn'],
      notify  => Service['coturn'];
    '/etc/turnserver.conf':
      ensure  => file,
      content => template("${module_name}/config"),
      owner   => '0',
      group   => '0',
      mode    => '0644',
      notify  => Service['coturn'],
  }

  logrotate::entry{ $module_name:
    content => template("${module_name}/logrotate")
  }

  $daemon_extra_args='--no-auth --no-dtls --no-tls --simple-log --no-stdout-log'

  package { 'coturn':
    provider => 'apt',
  }
  ->

  daemon { 'coturn':
    binary => '/usr/bin/turnserver',
    args   => "-c /etc/turnserver.conf -v -l /var/log/coturn/turnserver.log ${daemon_extra_args}",
    user   => 'turnserver',
  }
}
