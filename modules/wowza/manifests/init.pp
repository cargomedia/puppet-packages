class wowza (
  $version = '3.5.0',
  $license = 'SVRB3-44zj4-jCmwr-8PpPX-aYpxj-3Xdnw-6zcn6UfYy6N3'
) {

  require 'java'
  require 'ffmpeg'

  include 'wowza::service'

  user {'wowza':
    ensure => present,
  }

  helper::script {'install wowza':
    content => template('wowza/install.sh'),
    unless => "(test -x /usr/bin/WowzaMediaServerd) && (dpkg -l | grep -q '^ii.* wowzamediaserver-${version}')",
    timeout => 900,
    require => User['wowza'],
  }

  file {'/etc/init.d/wowza':
    ensure => file,
    content => template('wowza/init'),
    owner => '0',
    group => '0',
    mode => '0755',
    notify => Service['wowza'],
  }
  ~>

  exec {'update-rc.d wowza defaults  && /etc/init.d/wowza start':
    path => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
    refreshonly => true,
  }

  @monit::entry {'wowza':
    content => template('wowza/monit'),
  }

}
