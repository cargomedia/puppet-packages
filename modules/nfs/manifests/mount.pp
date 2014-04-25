define nfs::mount ($target = $name, $source, $mount = false, $mount_check = true) {

  require 'nfs'

  mount::entry {$target:
    source => $source,
    type => 'nfs4',
    mount => $mount,
    mount_check => $mount_check,
  }
}
