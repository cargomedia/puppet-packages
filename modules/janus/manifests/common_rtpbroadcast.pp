class janus::common_rtpbroadcast(
  $src_version = undef,
  $src_repo = undef,
) {

  require 'apt'
  require 'janus::common'

  if $src_version {
    require 'git'
    require 'build::autoconf'
    require 'build::libtool'
    require 'build::dev::libglib2'
    require 'build::dev::libjansson'
    require 'build::dev::libini_config'

    $src_path = '/opt/janus/janus-gateway-rtpbroadcast'
    $src_remote = $src_repo ? { undef => 'https://github.com/cargomedia/janus-gateway-rtpbroadcast.git',  default => $src_repo }
    git::repository { 'janus-gateway-rtpbroadcast':
      remote    => $src_remote,
      directory => $src_path,
      revision  => $src_version,
    }
    ~>

    exec { "Install ${name} from Source":
      provider    => shell,
      command     => template("${module_name}/plugin_install.sh"),
      path        => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
      refreshonly => true,
      timeout     => 900,
    }
  } else {

    apt::preference { ['janus-gateway-rtpbroadcast']:
      pin => "version 0.0.22-${::facts['lsbdistcodename']}1",
    }
    ->

    package { 'janus-gateway-rtpbroadcast':
      ensure   => present,
      provider => 'apt',
    }
  }
}
