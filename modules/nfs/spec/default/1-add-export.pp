node default {

  class {'nfs::server':
    configuration => '*(ro,sync,insecure,root_squash,no_subtree_check,fsid=0)'
  }

  file {'/tmp/source':
    ensure => directory,
  }
  ->

  file {'/tmp/source/foo':
    ensure => present,
  }
  ->

  nfs::server::export{'/shared':
      localPath => '/tmp/source',
      configuration => '*(rw,async,no_root_squash,no_subtree_check,fsid=1)',
  }
}
