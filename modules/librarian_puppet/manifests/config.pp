define librarian_puppet::config (
  $value,
  $path = undef,
  $user = 'root',
  $user_home = '/root'
) {

  $command_prefix = "librarian-puppet config ${name}"
  $unless_sufix = "${command_prefix} | grep ${name}"

  if ($path == undef) {
    $command = "${command_prefix} ${value} --global"
    $unless = $unless_sufix
  } else {
    $command = "cd ${path} && ${command_prefix} ${value} --local"
    $unless = "cd ${path} && ${unless_sufix}"
  }

  exec { "set config ${name} to ${value}":
    command     => $command,
    path        => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
    provider    => shell,
    user        => $user,
    environment => ["HOME=${user_home}"],
    unless      => $unless
  }

}
