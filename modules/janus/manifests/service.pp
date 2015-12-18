class janus::service (
  $config_file = '/etc/janus/janus.cfg',
  $plugin_config_dir = '/etc/janus',
) {

  require 'janus'
  require 'janus::transport::http'
  require 'janus::transport::websockets'

  $log_file = $janus::log_file

  if $janus::use_src {
    sysvinit::script { 'janus':
      content    => template("${module_name}/init.sh"),
    }
    ->

    service { 'janus':
      enable     => true,
      hasrestart => true,
      subscribe  => [
        Class['janus'],
        Class['janus::transport::http'],
        Class['janus::transport::websockets'],
      ]
    }

    @monit::entry { 'janus':
      content => template("${module_name}/monit"),
      require => Service['janus'],
    }

  } else {
     daemon { 'janus':
       binary => '/usr/bin/janus',
       args => "-o -C ${config_file} -F ${plugin_config_dir}",
       user => 'janus',
    }
  }
}
