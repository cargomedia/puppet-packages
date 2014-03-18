class nodejs {

  require 'build'

  $version = '0.10.22'

  if $::lsbdistcodename == 'wheezy' {
    package {['libevent-2.0-5', 'libssl-dev']:
      ensure => present,
      before => Helper::Script['install nodejs'],
    }
  }

  user {'nodejs':
    ensure => present,
    system => true,
  }

  helper::script {'install nodejs':
    content => template('nodejs/install.sh'),
    unless => "test -x /usr/bin/node && /usr/bin/node -v | grep '^v${version}$'",
    require => User['nodejs'],
    timeout => 900,
  }
}
