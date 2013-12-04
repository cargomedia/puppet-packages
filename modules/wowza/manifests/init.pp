class wowza (
  $version = '3.5.0',
  $port = 1935,
  $port_rpc = 8086,
  $license = 'SVRB3-44zj4-jCmwr-8PpPX-aYpxj-3Xdnw-6zcn6UfYy6N3'
) {

  require 'java'
  require 'ffmpeg'

  user {'wowza':
    ensure => present,
  }

  helper::script {'install wowza':
    content => template('wowza/install.sh'),
    unless => "test -x /usr/bin/WowzaMediaServerd) && (dpkg -l | grep -q '^ii.* wowzamediaserver-${version}'",
    timeout => 900,
    require => User['wowza'],
  }

  file {'/etc/init.d/wowza':
    ensure => file,
    content => template('wowza/init.d'),
  }

  @monit::entry {'wowza':
    content => template('wowza/monit'),
    require => Service['wowza'],
  }

  service {'wowza':
    ensure => running,
  }

}
