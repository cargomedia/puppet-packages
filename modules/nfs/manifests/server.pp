class nfs::server ($exports) {

  file {'/etc/exports':
    ensure => file,
    content => $exports,
    owner => '0',
    group => '0',
    mode => '0644',
  }

  ->
  package {'nfs-kernel-server':
    ensure => present,
  }
}
