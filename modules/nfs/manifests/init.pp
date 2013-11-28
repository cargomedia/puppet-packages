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
    # Bug or feature? Nfs-common install does not start service
    notify => Exec['Start nfs-common'],
  }

  exec { 'Start nfs-common':
    command => '/etc/init.d/nfs-common start',
    path => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
    unless => '/etc/init.d/nfs-common status',
    refreshonly => true,
  }

  service { 'nfs-common':
    require => Package ['nfs-common'],
  }
}
