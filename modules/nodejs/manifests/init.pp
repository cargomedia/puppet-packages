class nodejs ($version = '0.10.4') {

  require 'build'
  require 'python'

  package {['libevent-1.4-2', 'libssl-dev']:
    ensure => present
  }

  user {'nodejs':
    ensure => present,
    system => true,
  }

  helper::script {'install nodejs':
    content => template('nodejs/install.sh'),
    unless => "test -x /usr/bin/node && /usr/bin/node -v | grep '^v${version}$'",
    require => User['nodejs'],
  }
}
