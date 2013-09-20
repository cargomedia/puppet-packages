class nfs::server {

  require 'nfs'

  file { '/nfsexport':
    ensure => directory
  }

  file { '/etc/exports':
    ensure => file,
    content => template('nfs/exports'),
    group => 0,
    owner => 0,
    mode => '0644',
  }

  ->

  package {'nfs-kernel-server':
    ensure => present
  }

  service {'nfs-kernel-server':}

  exec {'reload_nfs_srv':
    command     => "/etc/init.d/nfs-kernel-server reload",
    onlyif      => '/etc/init.d/nfs-kernel-server status',
    refreshonly => true,

  }

}
