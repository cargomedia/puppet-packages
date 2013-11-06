node default {

  nfs::mount {'/tmp/mounted':
    source => 'localhost:/shared',
    mount => true,
  }
  ->

  file {'/tmp/mounted/bar':
    ensure => present,
  }
}