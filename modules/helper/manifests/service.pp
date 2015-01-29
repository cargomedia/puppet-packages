define helper::service(
  $init_file_content,
) {

  file { "/etc/init.d/${name}":
    ensure  => file,
    content => $init_file_content,
    owner   => '0',
    group   => '0',
    mode    => '0755',
  }
  ~>

  exec { "update-rc.d ${name} defaults":
    path        => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
    refreshonly => true,
  }
  ~>

  exec { "/etc/init.d/${name} start":
    path        => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
    unless      => "/etc/init.d/${name} status",
    refreshonly => true,
  }
}
