class timezone($code = 'Etc/UTC') {

  file {'/etc/timezone':
    ensure => file,
    content => "$code\n",
    owner => '0',
    group => '0',
    mode => '0644',
  }
  ~>

  exec {'/usr/sbin/dpkg-reconfigure -f noninteractive tzdata':
    refreshonly => true,
  }
}
