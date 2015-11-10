define janus::deps::plugin::lib {

  require 'build::autoconf'

  helper::script { "install janus plugin ${name}":
    content => template("${module_name}/deps/plugin/libinstall.sh"),
    unless  => "ls /opt/janus/lib/janus/plugins/libjanus_${name}.so",
    timeout => 900,
  }
}
