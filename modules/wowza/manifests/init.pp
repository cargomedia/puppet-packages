class wowza (
  $version = '3.5.0',
  $port = 1935,
  $port_rpc = 8086,
  $licence = 'xxxxx-xxxxx-xxxxx-xxxxx-xxxxx-xxxxx',
  $working_dir = '/usr/local/cargomedia/wowza'
) {

#  require 'ffmpeg'

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

  cron {"cron ${name}":
    command => "wowza find ${working_dir}/content -type f -mtime +1 -exec rm {}",
    user    => 'root',
    minute  => 30,
  }

  @monit::entry {'wowza':
    content => template('wowza/monit'),
    require => Service['wowza'],
  }

}
