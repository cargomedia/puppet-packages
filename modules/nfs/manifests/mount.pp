define nfs::mount ($target = $name, $source, $mount = false) {

  require 'nfs'

  mount::entry {$target:
    source => $source,
    type => 'nfs4',
    mount => $mount,
    notify => Service['nfs-common'],
  }
}