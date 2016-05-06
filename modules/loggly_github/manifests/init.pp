class loggly_github (
  $version = latest,
  $port,
  $secret,
  $github_token
) {
  require 'nodejs'

  user { 'loggly-github':
    ensure  => present,
    system  => true,
  }

  package { 'loggly-github':
    ensure   => $version,
    provider => 'npm',
  }

  file { '/etc/loggly-github':
    ensure => directory,
    owner  => '0',
    group  => '0',
    mode   => '0644',
  }

  file { '/etc/loggly-github/config.json':
    ensure  => file,
    content => template("${module_name}/config.json.erb"),
    owner   => '0',
    group   => '0',
    mode    => '0644',
    notify  => Service['loggly-github'],
  }

  daemon { 'loggly-github':
    binary    => '/usr/bin/node',
    args      => '/usr/bin/loggly-github --config /etc/loggly-github/config.json',
    user      => 'loggly-github',
    subscribe => Package['loggly-github'],
  }
}
