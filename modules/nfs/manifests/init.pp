class nfs {

  file { '/etc/default/nfs-common':
    ensure => file,
    content => template('nfs/default'),
    group => '0',
    owner => '0',
    mode => '0644',
  }
  ->

  file { '/etc/idmapd.conf':
    ensure => file,
    content => template('nfs/idmapd.conf'),
    group => '0',
    owner => '0',
    mode => '0644',
  }
  ->

  package { 'nfs-common':
    ensure => present,
    # Bug or feature? Nfs-common postinstall does not start service
    notify => Exec['Start nfs-common'],
  }

  exec { 'Start nfs-common':
    command   => '/etc/init.d/nfs-common start',
    path      => ['/bin', '/sbin'],
    unless    => '/etc/init.d/nfs-common status',
    logoutput => 'on_failure',
  }

  service { 'nfs-common':
    require => Package ['nfs-common'],
  }
}
