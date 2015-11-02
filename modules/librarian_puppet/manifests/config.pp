define librarian_puppet::config (
  $key,
  $value,
  $path = undef,
  $user = 'root',
  $user_home = '/root'
) {

  $command_prefix = "librarian-puppet config ${key}"

  if ($path == undef) {
    $command_option = '--global'
  } else {
    $command_option = '--local'
  }

  $command = "${command_prefix} ${value} ${command_option}"
  $unless = "${command_prefix} | grep ${key}"

  exec { "set librarian-puppet config ${key} to ${value}":
    command     => $command,
    path        => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
    provider    => shell,
    cwd         => $path,
    user        => $user,
    environment => ["HOME=${user_home}"],
    unless      => $unless,
  }

}
