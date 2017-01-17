node default {

  $reset_script = @(EOS)
  for fs in ext2 ext3 ext4; do
    for i in $(findmnt -lno source -t ${fs}); do
      tune2fs -c 30 -i 3m ${i}
    done;
  done;
    | EOS

  exec { 'Reset fsck params':
    provider    => shell,
    command     => $reset_script,
    path        => ['/usr/sbin', '/usr/bin', '/sbin', '/bin'],
  }
  ->

  class { 'fs::config::nofsck': }
}
