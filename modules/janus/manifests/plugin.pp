define janus::plugin(
  $src_version = undef,
) {

  require 'apt'
  require 'git'
  require 'build::autoconf'
  include 'janus'

  if not ($src_version) {
    package { "janus-gateway-${title}":
      provider => 'apt',
    }
  } else {
    git::repository { "Janus Plugin ${name}":
      remote    => 'https://github.com/meetecho/janus-gateway.git',
      directory => '/opt/janus/',
      revision  => "${src_version}",
    }
    ~>


    helper::script { "install janus plugin ${name}":
      content => template("${module_name}/plugin_install.sh"),
      unless  => "ls /opt/janus/lib/janus/plugins/libjanus_${name}.so",
      timeout => 900,
      require => Helper::Script['install janus'],
      notify  => Service['janus'],
    }
  }
}
