node default {
  nfs::server::export{'/shared':
      localPath => '/tmp',
      configuration => '*(rw,async,no_root_squash,no_subtree_check,fsid=1)',
  }
}
