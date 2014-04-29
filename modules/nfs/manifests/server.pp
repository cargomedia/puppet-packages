class nfs::server (
  $configuration = '*(ro,fsid=0)',
  $nfsd_count = 32
) {

  require 'nfs'

  file {'/nfsexport':
    ensure => directory,
    before => Package['nfs-kernel-server'],
  }

  file {'/etc/exports.d':
    ensure => directory,
    owner => '0',
    group => '0',
    mode => '755',
    before => Package['nfs-kernel-server'],
  }

  file {'/etc/default/nfs-kernel-server':
    ensure => file,
    content => template('nfs/server/default'),
    owner => '0',
    group => '0',
    mode => '644',
    notify => Service['nfs-kernel-server'],
  }
  ->

  package {'nfs-kernel-server':
    ensure => present
  }
  ->

  service {'nfs-kernel-server':}

  $rootExports = shellquote("/nfsexport ${$configuration}")
  exec {'/etc/exports':
    command => "echo ${rootExports} > /etc/exports; cat /etc/exports.d/* >> /etc/exports",
    path => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
    refreshonly => true,
    notify => Exec['/etc/init.d/nfs-kernel-server reload'],
    require => Service['nfs-kernel-server'],
  }

  exec {'/etc/init.d/nfs-kernel-server reload':
    command     => "/etc/init.d/nfs-kernel-server reload",
    onlyif      => '/etc/init.d/nfs-kernel-server status',
    refreshonly => true,
  }

  @monit::entry {'nfs-kernel-server':
    content => template('nfs/monit'),
    require => Service['nfs-kernel-server'],
  }

}
