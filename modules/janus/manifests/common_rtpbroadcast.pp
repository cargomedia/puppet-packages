class janus::common_rtpbroadcast(
  $src_version = undef,
) {

  require 'apt'
  require 'janus::common'

  if $src_version {
    require 'git'
    require 'build::autoconf'
    require 'build::libtool'
    require 'build::dev::libglib2'
    require 'build::dev::libjansson'

    $plugin_repo = 'janus-gateway-rtpbroadcast'

    git::repository { "${name}-${plugin_repo}":
      name      => $plugin_repo,
      remote    => "https://github.com/cargomedia/${plugin_repo}.git",
      directory => "/opt/janus/${plugin_repo}",
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
    package { "${name}-package":
      name     => 'janus-gateway-rtpbroadcast',
      provider => 'apt',
    }
  }
}
