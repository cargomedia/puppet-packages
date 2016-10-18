define systemd::daemon_reload {

  require 'systemd'

  exec { "systemd::reload for ${name}":
    command     => 'systemctl daemon-reload',
    path        => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
    refreshonly => true,
  }

}
