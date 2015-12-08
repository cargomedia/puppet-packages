class systemd::daemon_reload {

  require 'systemd'

  exec { 'systemctl daemon-reload':
    path        => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
    refreshonly => true,
  }

}
