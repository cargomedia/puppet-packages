class nodejs {

  require 'build'
  require 'python'

  $version = '0.10.22'

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
