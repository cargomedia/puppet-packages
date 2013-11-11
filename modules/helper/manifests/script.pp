define helper::script ($content, $unless) {

  $scriptName = md5($title)
  $scriptDirname = "/tmp/${scriptName}"
  $contentQuoted = shellquote($content)

  exec {"exec ${title}":
    provider => shell,
    environment => [
      'http_proxy=http://localhost:8123/',
      'HTTP_PROXY=http://localhost:8123/',
      'HTTPS_PROXY=http://localhost:8123/',
      'https_proxy=http://localhost:8123/',
    ],
    command => "mkdir -p ${scriptDirname} && cd ${scriptDirname} && echo ${contentQuoted} > ${scriptName} && chmod +x ${$scriptName} && ./${$scriptName}",
    unless => $unless,
    path => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
    logoutput => on_failure,
  }
  ~>

  exec {"cleanup ${title}":
    command => "rm -rf ${scriptDirname}",
    path => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
    refreshonly => true,
  }
}
