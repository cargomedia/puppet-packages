define helper::script ($content, $unless, $timeout = 300) {

  $scriptName = md5($title)
  $scriptDirname = "/tmp/${scriptName}"
  $contentQuoted = shellquote($content)

  exec {"exec ${title}":
    provider => shell,
    command => "mkdir -p ${scriptDirname} && cd ${scriptDirname} && echo ${contentQuoted} > ${scriptName} && chmod +x ${$scriptName} && ./${$scriptName}",
    unless => $unless,
    logoutput => on_failure,
    timeout => $timeout,
  }
  ~>

  exec {"cleanup ${title}":
    command => "rm -rf ${scriptDirname}",
    refreshonly => true,
  }
}
