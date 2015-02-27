define librarian_puppet::config (
  $value,
  $path = undef,
  $user = 'root',
  $user_home = '/root'
) {

  $command_prefix = "librarian-puppet config ${name}"

  if ($path == undef) {
    $command_option = '--global'
  } else {
    $command_option = '--local'
  }

  $command = "${command_prefix} ${value} ${command_option}"
  $unless = "${command_prefix} | grep ${name}"

  exec { "set librairan-puppet config ${name} to ${value}":
    command     => $command,
    path        => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
    provider    => shell,
    cwd         => $path,
    user        => $user,
    environment => ["HOME=${user_home}"],
    unless      => $unless,
  }

}
