class apt::sources {

  file { '/etc/apt/sources.list':
    source => 'puppet:///modules/apt/sources',
    ensure => file,
    group => '0',
    owner => '0',
    mode => '0644',
  }

  exec { 'apt_update':
    command     => "/usr/bin/apt-get update",
    logoutput   => 'on_failure',
    subscribe   => File["/etc/apt/sources.list"],
    refreshonly => true,
  }
}
