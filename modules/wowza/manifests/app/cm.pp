class wowza::app::cm (
  $ip = 'localhost',
  $port = 1935,
  $port_rpc = 8086,
  $dir = '/usr/local/cargomedia/wowza',
  $cm_conf_dir = '/usr/local/cargomedia/wowza/conf',
  $wowza_conf_dir = '/usr/local/WowzaMediaServer/conf',
  $archive_dir = '/home/fuckbook/shared/userfiles/streamChannels',
  $rpc_url = 'https://localhost/rpc/null',
  $jmxremote_access = undef,
  $jmxremote_passwd = undef
) {

  require 'wowza'
  require 'wowza::jar::cm-wowza'

  exec {'install paths':
    command => "mkdir -p ${dir} ${cm_conf_dir} ${dir}/content ${dir}/applications/videchat ${archive_dir}",
    creates => $dir,
    path => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
    user => 'wowza',
  }
  ->

  # wowza configuration
  file {"${wowza_conf_dir}/Server.xml":
    ensure => file,
    content => template('wowza/app/cm/Server.xml'),
    owner => 'wowza',
    group => 'wowza',
    mode => '0755',
    notify => Service['wowza'],
  }
  ->

  file {"${wowza_conf_dir}/VHosts.xml":
    ensure => file,
    content => template('wowza/app/cm/VHosts.xml'),
    owner => 'wowza',
    group => 'wowza',
    mode => '0755',
    notify => Service['wowza'],
  }
  ->

  # video chat application
  file {"${cm_conf_dir}/videochat":
    ensure => directory,
    owner => 'wowza',
    group => 'wowza',
    mode => '0755',
  }
  ->

  file {"${cm_conf_dir}/videochat/Application.xml":
    ensure => file,
    content => template('wowza/app/cm/wowza/conf/videochat/Application.xml'),
    owner => 'wowza',
    group => 'wowza',
    mode => '0755',
    notify => Service['wowza'],
  }
  ->

  # cm application configuration
  file {"${cm_conf_dir}/Authentication.xml":
    ensure => file,
    content => template('wowza/app/cm/wowza/conf/Authentication.xml'),
    owner => 'wowza',
    group => 'wowza',
    mode => '0755',
    notify => Service['wowza'],
  }
  ->

  file {"${cm_conf_dir}/DVR.xml":
    ensure => file,
    content => template('wowza/app/cm/wowza/conf/DVR.xml'),
    owner => 'wowza',
    group => 'wowza',
    mode => '0755',
    notify => Service['wowza'],
  }
  ->

  file {"${cm_conf_dir}/HTTPStreamers.xml":
    ensure => file,
    content => template('wowza/app/cm/wowza/conf/HTTPStreamers.xml'),
    owner => 'wowza',
    group => 'wowza',
    mode => '0755',
    notify => Service['wowza'],
  }
  ->

  file {"${cm_conf_dir}/jmxremote.access":
    ensure => file,
    content => $jmxremote_access,
    owner => 'wowza',
    group => 'wowza',
    mode => '0755',
    notify => Service['wowza'],
  }
  ->

  file {"${cm_conf_dir}/jmxremote.password":
    ensure => file,
    content => $jmxremote_passwd,
    owner => 'wowza',
    group => 'wowza',
    mode => '0755',
    notify => Service['wowza'],
  }
  ->

  file {"${cm_conf_dir}/LiveStreamPacketizers.xml":
    ensure => file,
    content => template('wowza/app/cm/wowza/conf/LiveStreamPacketizers.xml'),
    owner => 'wowza',
    group => 'wowza',
    mode => '0755',
    notify => Service['wowza'],
  }
  ->

  file {"${cm_conf_dir}/LiveStreamTranscoders.xml":
    ensure => file,
    content => template('wowza/app/cm/wowza/conf/LiveStreamTranscoders.xml'),
    owner => 'wowza',
    group => 'wowza',
    mode => '0755',
    notify => Service['wowza'],
  }
  ->

  file {"${cm_conf_dir}/log4j.properties":
    ensure => file,
    content => template('wowza/app/cm/wowza/conf/log4j.properties'),
    owner => 'wowza',
    group => 'wowza',
    mode => '0755',
    notify => Service['wowza'],
  }
  ->

  file {"${cm_conf_dir}/MediaCasters.xml":
    ensure => file,
    content => template('wowza/app/cm/wowza/conf/MediaCasters.xml'),
    owner => 'wowza',
    group => 'wowza',
    mode => '0755',
    notify => Service['wowza'],
  }
  ->

  file {"${cm_conf_dir}/MediaReaders.xml":
    ensure => file,
    content => template('wowza/app/cm/wowza/conf/MediaReaders.xml'),
    owner => 'wowza',
    group => 'wowza',
    mode => '0755',
    notify => Service['wowza'],
  }
  ->

  file {"${cm_conf_dir}/MediaWriters.xml":
    ensure => file,
    content => template('wowza/app/cm/wowza/conf/MediaWriters.xml'),
    owner => 'wowza',
    group => 'wowza',
    mode => '0755',
    notify => Service['wowza'],
  }
  ->

  file {"${cm_conf_dir}/MP3Tags.xml":
    ensure => file,
    content => template('wowza/app/cm/wowza/conf/MP3Tags.xml'),
    owner => 'wowza',
    group => 'wowza',
    mode => '0755',
    notify => Service['wowza'],
  }
  ->

  file {"${cm_conf_dir}/RTP.xml":
    ensure => file,
    content => template('wowza/app/cm/wowza/conf/RTP.xml'),
    owner => 'wowza',
    group => 'wowza',
    mode => '0755',
    notify => Service['wowza'],
  }
  ->

  file {"${cm_conf_dir}/StartupStreams.xml":
    ensure => file,
    content => template('wowza/app/cm/wowza/conf/StartupStreams.xml'),
    owner => 'wowza',
    group => 'wowza',
    mode => '0755',
    notify => Service['wowza'],
  }
  ->

  file {"${cm_conf_dir}/Streams.xml":
    ensure => file,
    content => template('wowza/app/cm/wowza/conf/Streams.xml'),
    owner => 'wowza',
    group => 'wowza',
    mode => '0755',
    notify => Service['wowza'],
  }
  ->

  file {"${cm_conf_dir}/VHost.xml":
    ensure => file,
    content => template('wowza/app/cm/wowza/conf/VHost.xml'),
    owner => 'wowza',
    group => 'wowza',
    mode => '0755',
    notify => Service['wowza'],
  }
  ->

  cron {"cron ${name}":
    command => "wowza find ${dir}/content -type f -mtime +1 -exec rm {}",
    user    => 'root',
    minute  => 30,
  }

}
