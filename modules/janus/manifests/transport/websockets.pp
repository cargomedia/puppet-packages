define janus::transport::websockets(
  $prefix = '/',
  $ws = 'yes',
  $ws_port = 8310,
  $wss = 'no',
  $wss_port = 8311,
  $ws_logging = 0,
  $ws_acl = undef,
  $admin_ws = 'no',
  $admin_ws_port = 8312,
  $admin_wss = 'no',
  $admin_wss_port = 8313,
  $admin_wss_acl = '127.,192.168.',
) {

  if ($prefix != '/') {
    $home_path = "${prefix}/${name}"
    $instance_name = "janus_${name}"
  } else {
    $home_path = ''
    $instance_name = 'janus'
  }

  file { "${home_path}/etc/janus/janus.transport.websockets.cfg":
    ensure    => 'present',
    content   => template("${module_name}/transport/websockets.cfg"),
    owner     => '0',
    group     => '0',
    mode      => '0644',
    notify    => Service[$instance_name],
  }
}
