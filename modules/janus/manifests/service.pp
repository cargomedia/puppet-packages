class janus::service {

  require 'janus'
  require 'janus::transport::http'
  require 'janus::transport::websockets'

  $log_file = $janus::log_file


  daemon { 'janus':
    binary => '/usr/bin/janus',
    args => '-o -C /etc/janus/janus.cfg -F /etc/janus',
    user => 'janus',
  }

}
