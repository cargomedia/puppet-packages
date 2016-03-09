class janus::common_audioroom(
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
    require 'build::dev::libopus'

    $src_path = '/opt/janus/janus-gateway-audioroom'
    $src_remote = $src_repo ? { undef => 'https://github.com/cargomedia/janus-gateway-audioroom.git',  default => $src_repo }
    git::repository { 'janus-gateway-audioroom':
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
    package { 'janus-gateway-audioroom':
      provider => 'apt',
    }
  }
}
