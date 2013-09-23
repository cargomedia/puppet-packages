class nfs {

  file { '/etc/default/nfs-common':
    ensure => file,
    content => template('nfs/default'),
    group => '0',
    owner => '0',
    mode => '0644',
  }
}
