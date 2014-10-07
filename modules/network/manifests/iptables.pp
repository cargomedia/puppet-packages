define network::iptables (
  $command = 'append',
  $table = 'filter',
  $chain,
  $rule
) {

  exec {$title:
    provider => shell,
    command  => "iptables --table ${table} --${command} ${chain} ${rule}",
    unless   => "iptables --table ${table} --check ${chain} ${rule}",
    path     => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
    user     => 'root',
  }
}
