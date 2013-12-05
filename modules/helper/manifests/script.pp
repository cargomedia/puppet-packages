define helper::script ($content, $unless, $timeout = 300, $user = undef, $environment = undef) {

  $scriptName = md5($title)
  $scriptDirname = "/tmp/${scriptName}"

  exec {"exec ${title}":
    provider => shell,
    command => template('helper/script.sh'),
    unless => $unless,
    path => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
    logoutput => on_failure,
    timeout => $timeout,
    user => $user,
    environment => $environment ? {
      undef => hiera('helper::script::environment', []),
      default => $environment,
    },
  }
  ~>

  exec {"cleanup ${title}":
    command => "rm -rf ${scriptDirname}",
    path => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
    refreshonly => true,
  }
}
