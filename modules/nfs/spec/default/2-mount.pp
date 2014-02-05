node default {

  exec {'be_kind_and_relax_just_5_sec':
    command => "sleep 5",
    path => "/usr/bin:/bin",
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
