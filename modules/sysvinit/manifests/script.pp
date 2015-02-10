define sysvinit::script(
  $content,
) {

  file { "/etc/init.d/${name}":
  ensure  => file,
  content => $content,
  owner   => '0',
  group   => '0',
  mode    => '0755',
  }

  exec { "/etc/init.d/${name} start":
    path        => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
    unless      => "/etc/init.d/${name} status",
    subscribe   => File["/etc/init.d/${name}"],
    refreshonly => true,
  }

}
