define helper::service {

  exec {"update-rc.d ${name} defaults":
    path => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
    unless => "ls /etc/rc3.d/ | grep -- '^S..${name}$'",
  }
  ~>

  exec {"/etc/init.d/${name} start":
    path => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
    unless => "/etc/init.d/${name} status",
    refreshonly => true,
  }
}
