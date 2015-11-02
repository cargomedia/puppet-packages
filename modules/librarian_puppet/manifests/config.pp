define librarian_puppet::config (
  $key,
  $value,
  $path = undef,
  $user = 'root',
  $user_home = '/root'
) {

  if ($path == undef) {
    $command_prefix = 'librarian-puppet config --global'
  } else {
    $command_prefix = 'librarian-puppet config --local'
  }

  $command = "${command_prefix} ${key} ${value}"
  $unless = "${command_prefix} ${key} | grep ${value}"

  exec { "${name} - apply librarian-puppet config":
    command     => $command,
    path        => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
    provider    => shell,
    cwd         => $path,
    user        => $user,
    environment => ["HOME=${user_home}"],
    unless      => $unless,
  }

}
