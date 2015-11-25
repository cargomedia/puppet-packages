define janus::plugin {

  require 'build::autoconf'
  include 'janus::version'
  include 'janus::service'
  include 'janus'

  $janus_version = $janus::version::main

  git::repository { 'janus-gateway':
    remote      => 'https://github.com/meetecho/janus-gateway.git',
    directory   => '/opt/src/janus',
    revision    => $janus::version::main,
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
