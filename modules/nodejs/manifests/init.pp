class nodejs {

  package {'nodejs':
    ensure => present,
  }
  package {'nodejs-legacy':
    ensure => present
  }

  exec {'install npm':
    command => 'curl https://www.npmjs.org/install.sh | clean=yes sh',
    unless => 'test -x /usr/bin/npm && /usr/bin/npm -v',
    path => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
    require => Package['nodejs-legacy'],
  }

}
