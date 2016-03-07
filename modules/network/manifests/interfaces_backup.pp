class network::interfaces_backup {

  exec { 'Backup existing network config':
    provider => shell,
    command  => 'cp /etc/network/interfaces /etc/network/interfaces.bak',
    unless   => 'ls /etc/network/interfaces.bak',
    path     => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
    user     => 'root',
  }
}
