class wowza::app::cm (
  $port = 1935,
  $port_rpc = 8086,
  $dir = '/usr/local/cargomedia/wowza',
  $archive_dir = '/home/default/shared/userfiles/streamChannels',
  $rpc_url = 'https://localhost/rpc/null',
  $jmxremote_access = ['monitor readonly'],
  $jmxremote_passwd = ['monitor mypassword']
) {

  require 'wowza'
  require 'wowza::jar::cm-wowza'

  exec {"${name} install paths":
    command => "mkdir -p ${dir}/conf ${dir}/content ${dir}/applications/videchat ${archive_dir}",
    creates => $dir,
    path => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
    user => 'wowza',
  }
  ->

  # wowza configuration
  file {"/usr/local/WowzaMediaServer/conf/Server.xml":
    ensure => file,
    content => template('wowza/app/cm/Server.xml'),
    owner => 'wowza',
    group => 'wowza',
    mode => '0755',
    notify => Service['wowza'],
  }
  ->

  file {"/usr/local/WowzaMediaServer/conf/VHosts.xml":
    ensure => file,
    content => template('wowza/app/cm/VHosts.xml'),
    owner => 'wowza',
    group => 'wowza',
    mode => '0755',
    notify => Service['wowza'],
  }
  ->

  # video chat application
  file {"${dir}/conf/videochat":
    ensure => directory,
    owner => 'wowza',
    group => 'wowza',
    mode => '0755',
  }
  ->

  file {"${dir}/conf/videochat/Application.xml":
    ensure => file,
    content => template('wowza/app/cm/wowza/conf/videochat/Application.xml'),
    owner => 'wowza',
    group => 'wowza',
    mode => '0755',
    notify => Service['wowza'],
  }
  ->

  # cm application configuration
  file {"${dir}/conf/Authentication.xml":
    ensure => file,
    content => template('wowza/app/cm/wowza/conf/Authentication.xml'),
    owner => 'wowza',
    group => 'wowza',
    mode => '0755',
    notify => Service['wowza'],
  }
  ->

  file {"${dir}/conf/DVR.xml":
    ensure => file,
    content => template('wowza/app/cm/wowza/conf/DVR.xml'),
    owner => 'wowza',
    group => 'wowza',
    mode => '0755',
    notify => Service['wowza'],
  }
  ->

  file {"${dir}/conf/HTTPStreamers.xml":
    ensure => file,
    content => template('wowza/app/cm/wowza/conf/HTTPStreamers.xml'),
    owner => 'wowza',
    group => 'wowza',
    mode => '0755',
    notify => Service['wowza'],
  }
  ->

  file {"${dir}/conf/jmxremote.access":
    ensure => file,
    content => template('wowza/app/cm/wowza/conf/jmxremote.access'),
    owner => 'wowza',
    group => 'wowza',
    mode => '0755',
    notify => Service['wowza'],
  }
  ->

  file {"${dir}/conf/jmxremote.password":
    ensure => file,
    content => template('wowza/app/cm/wowza/conf/jmxremote.password'),
    owner => 'wowza',
    group => 'wowza',
    mode => '0755',
    notify => Service['wowza'],
  }
  ->

  file {"${dir}/conf/LiveStreamPacketizers.xml":
    ensure => file,
    content => template('wowza/app/cm/wowza/conf/LiveStreamPacketizers.xml'),
    owner => 'wowza',
    group => 'wowza',
    mode => '0755',
    notify => Service['wowza'],
  }
  ->

  file {"${dir}/conf/LiveStreamTranscoders.xml":
    ensure => file,
    content => template('wowza/app/cm/wowza/conf/LiveStreamTranscoders.xml'),
    owner => 'wowza',
    group => 'wowza',
    mode => '0755',
    notify => Service['wowza'],
  }
  ->

  file {"${dir}/conf/log4j.properties":
    ensure => file,
    content => template('wowza/app/cm/wowza/conf/log4j.properties'),
    owner => 'wowza',
    group => 'wowza',
    mode => '0755',
    notify => Service['wowza'],
  }
  ->

  file {"${dir}/conf/MediaCasters.xml":
    ensure => file,
    content => template('wowza/app/cm/wowza/conf/MediaCasters.xml'),
    owner => 'wowza',
    group => 'wowza',
    mode => '0755',
    notify => Service['wowza'],
  }
  ->

  file {"${dir}/conf/MediaReaders.xml":
    ensure => file,
    content => template('wowza/app/cm/wowza/conf/MediaReaders.xml'),
    owner => 'wowza',
    group => 'wowza',
    mode => '0755',
    notify => Service['wowza'],
  }
  ->

  file {"${dir}/conf/MediaWriters.xml":
    ensure => file,
    content => template('wowza/app/cm/wowza/conf/MediaWriters.xml'),
    owner => 'wowza',
    group => 'wowza',
    mode => '0755',
    notify => Service['wowza'],
  }
  ->

  file {"${dir}/conf/MP3Tags.xml":
    ensure => file,
    content => template('wowza/app/cm/wowza/conf/MP3Tags.xml'),
    owner => 'wowza',
    group => 'wowza',
    mode => '0755',
    notify => Service['wowza'],
  }
  ->

  file {"${dir}/conf/RTP.xml":
    ensure => file,
    content => template('wowza/app/cm/wowza/conf/RTP.xml'),
    owner => 'wowza',
    group => 'wowza',
    mode => '0755',
    notify => Service['wowza'],
  }
  ->

  file {"${dir}/conf/StartupStreams.xml":
    ensure => file,
    content => template('wowza/app/cm/wowza/conf/StartupStreams.xml'),
    owner => 'wowza',
    group => 'wowza',
    mode => '0755',
    notify => Service['wowza'],
  }
  ->

  file {"${dir}/conf/Streams.xml":
    ensure => file,
    content => template('wowza/app/cm/wowza/conf/Streams.xml'),
    owner => 'wowza',
    group => 'wowza',
    mode => '0755',
    notify => Service['wowza'],
  }
  ->

  file {"${dir}/conf/VHost.xml":
    ensure => file,
    content => template('wowza/app/cm/wowza/conf/VHost.xml'),
    owner => 'wowza',
    group => 'wowza',
    mode => '0755',
    notify => Service['wowza'],
  }
  ->

  cron {"${name} cleanup content":
    command => "wowza find ${dir}/content -type f -mtime +1 -exec rm {}",
    user    => 'root',
    minute  => 30,
  }

}
