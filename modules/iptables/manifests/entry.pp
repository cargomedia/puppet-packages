define iptables::entry (
  $command = 'append',
  $table = 'filter',
  $chain = undef,
  $rule = undef
) {

  require 'iptables'

  exec { $title:
    provider => shell,
    command  => "iptables --table ${table} --${command} ${chain} ${rule}",
    unless   => "iptables --table ${table} --check ${chain} ${rule}",
    path     => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
    user     => 'root',
  }
}
