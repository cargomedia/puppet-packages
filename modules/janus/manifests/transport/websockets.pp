class janus::transport::websockets(
  $ws = 'yes',
  $ws_port = 8310,
  $wss = 'no',
  $wss_port = 8311,
  $ws_logging = 0,
  $ws_acl = '127.,192.168.',
  $admin_ws = 'no',
  $admin_ws_port = 8312,
  $admin_wss = 'no',
  $admin_wss_port = 8313,
  $admin_ws_acl = '127.,192.168.',
) {

  file { '/etc/janus/janus.transport.websockets.cfg':
    ensure    => 'present',
    content   => template("${module_name}/transport/websockets.cfg"),
    owner     => '0',
    group     => '0',
    mode      => '0644',
    notify    => Service['janus'],
  }
  ->

  janus::transport { $name: }

}
