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

  package {'nfs-common':
    ensure => present,
  }

  service {'nfs-common':
  }
}
