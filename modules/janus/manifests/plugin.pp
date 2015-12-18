define janus::plugin {

  require 'apt'
  require 'build::autoconf'
  include 'janus::version'
  include 'janus::service'
  include 'janus'

  $janus_version = $janus::version::number

  if $janus::use_src {
    helper::script { "install janus plugin ${name}":
      content => template("${module_name}/plugin_install.sh"),
      unless  => "ls /opt/janus/lib/janus/plugins/libjanus_${name}.so",
      timeout => 900,
      require => Helper::Script['install janus'],
      notify  => Service['janus'],
    }
  } else {
    package { "janus-gateway-${title}":
      provider => 'apt',
    }
  }

}
