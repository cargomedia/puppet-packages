define ssh::id ($host, $user, $sshDir, $private, $public, $type = 'ssh-rsa') {

  require 'ssh'

  exec {"${sshDir} for ${host}":
    command => "mkdir -p ${sshDir}",
    creates => $sshDir,
  }

  file {"${sshDir}/${host}":
    ensure => file,
    content => $private,
    group => '0',
    owner => $user,
    mode => '0600',
    require => Exec["${sshDir} for ${host}"],
  }

  file {"${sshDir}/${host}.pub":
    ensure => file,
    content => template('ssh/public'),
    group => '0',
    owner => $user,
    mode => '0644',
    require => Exec["${sshDir} for ${host}"],
  }

  exec {"mkdir ${sshDir}/config.d for ${host}":
    provider => shell,
    command => "mkdir -p ${sshDir}/config.d",
    creates => "${sshDir}/config.d",
    user => $user,
    require => Exec["${sshDir} for ${host}"],
  }
  ->

  file {"${sshDir}/config.d/${host}":
    ensure => file,
    content => template('ssh/config-host'),
    group => '0',
    owner => $user,
    mode => '0644',
    notify => Exec["${sshDir}/config by ${host}"],
  }

  exec {"${sshDir}/config by ${host}":
    command => "cat ${sshDir}/config.d/* > ${sshDir}/config",
    user => $user,
    refreshonly => true,
    require => Exec["${sshDir} for ${host}"],
  }
}
