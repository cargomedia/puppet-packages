node default {

  exec {'wait_5_sec_for_nfs_export_to_become_ready':
    command => "sleep 5",
    path  => ['/bin', '/usr/bin'],
  }
  ->

  nfs::mount {'/tmp/mounted':
    source => 'localhost:/shared',
    mount => true,
  }
  ->

  file {'/tmp/mounted/bar':
    ensure => present,
  }
}
