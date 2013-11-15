define puppet::git-modules ($source, $version = 'master') {

  require 'git'
  include 'puppet::common'

  $path = "/etc/puppet/repos/${name}"
  $pathEscaped = shellquote($path)
  $versionEscaped = shellquote($version)
  $versionCommand = "\$(git rev-list origin/${versionEscaped} -1 2>/dev/null || git rev-list ${versionEscaped} -1)"
  $updateCommand = "cd ${pathEscaped} && git fetch --quiet origin && git fetch --quiet --tags origin && git checkout --quiet ${versionCommand}"

  exec {"puppet repo ${name}":
    command => "git clone ${source} ${pathEscaped}",
    creates => $path,
    require => Package['git'],
    notify => Exec['/etc/puppet/conf.d/main-modulepath'],
  }
  ->

  exec {$updateCommand:
    provider => shell,
    cwd => $pathEscaped,
    unless => "git fetch origin && test $(git rev-list HEAD -1) = ${versionCommand}",
  }
  ->

  cron {"cron git-modules-update ${name}":
    command => $updateCommand,
    user    => 'root',
  }
}
