define puppet::git-modules ($source, $version = 'master') {

  include 'puppet::common'
  require 'git'

  $path = "/etc/puppet/repos/${name}"
  $updateCommand = "/usr/local/bin/git-modules-update-${name}"

  file {$updateCommand:
    ensure => file,
    content => template('puppet/git-modules/update.sh'),
    owner => '0',
    group => '0',
    mode => '755',
  }
  ->

  exec {"puppet repo ${name}":
    command => "git clone ${source} ${path}; ${updateCommand}",
    path => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
    creates => $path,
    notify => Exec['/etc/puppet/conf.d/main-modulepath'],
  }
  ->

  cron {"cron ${updateCommand}":
    command => $updateCommand,
    user    => root,
  }
}
