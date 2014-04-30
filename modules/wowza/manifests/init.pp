class wowza (
  $version = '4.0.3',
  $license = 'EDEV4-HNGXC-T3rK3-axKB3-ncwW6-aHhB6-KQJRHWV3hHA',
  $admin_user = 'root',
  $admin_password = 'root'
) {

  require 'java'
  require 'ffmpeg'

  include 'wowza::service'

  user {'wowza':
    ensure => present,
  }

  helper::script {'install wowza':
    content => template('wowza/install.sh'),
    unless => "(test -x /usr/bin/WowzaStreamingEngined) && (dpkg -l | grep -q '^ii.* wowzastreamingengine-${version}')",
    timeout => 900,
    require => User['wowza'],
  }
  ->

  file {
    '/usr/local/WowzaStreamingEngine/conf/admin.password':
      ensure =>file,
      content => template('wowza/admin.password'),
      owner => '0',
      group => '0',
      mode => '0755',
      notify => Service['wowza'];

    '/usr/local/WowzaStreamingEngine/conf/Server.license':
      ensure => file,
      content => $license,
      owner => '0',
      group => '0',
      mode => '0755',
      notify => Service['wowza'];

    '/etc/init.d/wowza':
      ensure => file,
      content => template('wowza/init'),
      owner => '0',
      group => '0',
      mode => '0755',
      notify => Service['wowza'];
  }
  ~>

  exec {'update-rc.d wowza defaults && /etc/init.d/wowza start':
    path => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
    refreshonly => true,
  }

  @monit::entry {'wowza':
    content => template('wowza/monit'),
  }

}
