class janus::service (
  $config_file = '/etc/janus/janus.cfg',
  $plugin_config_dir = '/etc/janus',
) {

  require 'janus'
  require 'janus::transport::http'
  require 'janus::transport::websockets'

  $log_file = $janus::log_file


  daemon { 'janus':
    binary => '/usr/bin/janus',
    args => "-o -C ${config_file} -F ${plugin_config_dir}",
    user => 'janus',
  }

}
