class wowza::app::cm (
  $ip = 'localhost',
  $dir = '/usr/local/cargomedia/wowza',
  $rpc_url = 'https://localhost/rpc/null',
  $archive_dir = '/home/fuckbook/shared/userfiles/streamChannels',
  $wowza_conf_dir = '/usr/local/WowzaMediaServer/conf/',
  $cm_conf_dir = '/usr/local/cargomedia/wowza/conf',
  $jmxremote_access = undef,
  $jmxremote_passwd = undef
) {

  require 'wowza::jar::cm-wowza'

  File {
    ensure => file,
    owner => 'wowza',
    mode => '0755',
  }

  exec {'install paths':
    command => "mkdir -p ${dir} ${cm_conf_dir} ${dir}/content ${dir}/applications/videchat",
    creates => $dir,
    path => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
    require => Class['wowza::jar::cm-wowza'],
  }
  ->

  # wowza configuration
  file {"${wowza_conf_dir}/Server.xml":
    content => template('wowza/app/cm/Server.xml'),
  }
  ->

  file {"${wowza_conf_dir}/VHosts.xml":
    content => template('wowza/app/cm/VHosts.xml'),
  }
  ->

  # video chat application
  file {"${cm_conf_dir}/videochat":
    ensure => directory,
  }
  ->

  file {"${cm_conf_dir}/videochat/Application.xml":
    content => template('wowza/app/cm/wowza/conf/videochat/Application.xml'),
  }
  ->

  # cm application configuration
  file {"${cm_conf_dir}/Authentication.xml":
    content => template('wowza/app/cm/wowza/conf/Authentication.xml'),
  }
  ->

  file {"${cm_conf_dir}/DVR.xml":
    content => template('wowza/app/cm/wowza/conf/DVR.xml'),
  }
  ->

  file {"${cm_conf_dir}/HTTPStreamers.xml":
    content => template('wowza/app/cm/wowza/conf/HTTPStreamers.xml'),
  }
  ->

  file {"${cm_conf_dir}/jmxremote.access":
    content => $jmxremote_access,
  }
  ->

  file {"${cm_conf_dir}/jmxremote.password":
    content => $jmxremote_passwd,
  }
  ->

  file {"${cm_conf_dir}/LiveStreamPacketizers.xml":
    content => template('wowza/app/cm/wowza/conf/LiveStreamPacketizers.xml'),
  }
  ->

  file {"${cm_conf_dir}/LiveStreamTranscoders.xml":
    content => template('wowza/app/cm/wowza/conf/LiveStreamTranscoders.xml'),
  }
  ->

  file {"${cm_conf_dir}/log4j.properties":
    content => template('wowza/app/cm/wowza/conf/log4j.properties'),
  }
  ->

  file {"${cm_conf_dir}/MediaCasters.xml":
    content => template('wowza/app/cm/wowza/conf/MediaCasters.xml'),
  }
  ->

  file {"${cm_conf_dir}/MediaReaders.xml":
    content => template('wowza/app/cm/wowza/conf/MediaReaders.xml'),
  }
  ->

  file {"${cm_conf_dir}/MediaWriters.xml":
    content => template('wowza/app/cm/wowza/conf/MediaWriters.xml'),
  }
  ->

  file {"${cm_conf_dir}/MP3Tags.xml":
    content => template('wowza/app/cm/wowza/conf/MP3Tags.xml'),
  }
  ->

  file {"${cm_conf_dir}/RTP.xml":
    content => template('wowza/app/cm/wowza/conf/RTP.xml'),
  }
  ->

  file {"${cm_conf_dir}/StartupStreams.xml":
    content => template('wowza/app/cm/wowza/conf/StartupStreams.xml'),
  }
  ->

  file {"${cm_conf_dir}/Streams.xml":
    content => template('wowza/app/cm/wowza/conf/Streams.xml'),
  }
  ->

  file {"${cm_conf_dir}/VHost.xml":
    content => template('wowza/app/cm/wowza/conf/VHost.xml'),
  }

}
