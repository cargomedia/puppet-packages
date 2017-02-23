class systemd::config::journald (
  $storage             = 'persistent',
  $rate_limit_interval = '5s',
  $rate_limit_burst    = 500,
  $max_retention_sec   = '6month',
) {

  require 'systemd'

  file { '/etc/systemd/journald.conf':
    ensure  => file,
    owner   => '0',
    group   => '0',
    mode    => '0644',
    content => template("${module_name}/journald.conf.erb"),
    notify  => Exec['restart systemd-journald due to config change'],
  }

  exec { 'restart systemd-journald due to config change':
    command     => 'systemctl restart systemd-journald',
    path        => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
    refreshonly => true,
  }
}