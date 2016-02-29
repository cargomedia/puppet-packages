define janus::transport::websockets(
  $origin = false,
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

  $instance_name = $origin ? {
    true     => 'janus',
    default  => "janus_${title}",
  }

  $base_dir = $origin ? {
    true    => '',
    default => "/opt/janus-cluster/${title}",
  }

  file { "${base_dir}/usr/lib/janus/transports/libjanus_websockets.so":
    ensure => link,
    target => '/usr/lib/janus/transports/libjanus_websockets.so',
  }
  ->

  file { "${base_dir}/etc/janus/janus.transport.websockets.cfg":
    ensure    => 'present',
    content   => template("${module_name}/transport/websockets.cfg"),
    owner     => '0',
    group     => '0',
    mode      => '0644',
    notify    => Service[$instance_name],
  }
}
