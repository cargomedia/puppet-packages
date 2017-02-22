define helper::script (
  $content,
  $unless,
  $timeout     = 300,
  $user        = undef,
  $environment = undef
) {

  $scriptName = md5($title)
  $scriptDirname = "/tmp/${scriptName}"
  $scriptEnv = $environment ? {
    undef   => lookup('helper::script::environment', Array, 'unique', []),
    default => $environment,
  }

  exec { "exec ${title}":
    provider    => shell,
    command     => template("${module_name}/script.sh"),
    unless      => $unless,
    path        => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
    logoutput   => on_failure,
    timeout     => $timeout,
    user        => $user,
    environment => $scriptEnv,
  }
  ~>

  exec { "cleanup ${title}":
    command     => "rm -rf ${scriptDirname}",
    path        => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
    refreshonly => true,
  }
}
