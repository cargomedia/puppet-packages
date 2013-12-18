define sysctl::entry ($entries) {

  $localEntries = $entries

  file {"/etc/sysctl.d/${name}":
    ensure => file,
    content => template('sysctl/sysctl'),
    owner => '0',
    group => '0',
    mode => '0644',
  }
  ~>

  exec {'sysctl reload':
    path => '/sbin',
    command => "sysctl -p /etc/sysctl.d/${name}",
    refreshonly => true,
  }
}
