node default {

  exec { 'Reset fsck params':
    provider    => shell,
    command     => 'tune2fs -c 30 -i 3m /dev/sda1',
    path        => ['/usr/sbin', '/usr/bin', '/sbin', '/bin'],
  }
  ->

  class { 'fs::config::nofsck': }
}
