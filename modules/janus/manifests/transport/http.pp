define janus::transport::http(
  $prefix = '/',
  $base_path = '/janus',
  $threads = 'unlimited',
  $http = 'yes',
  $port = 8300,
  $https = 'no',
  $secure_port = 8301,
  $acl = undef,
  $admin_base_path = '/admin',
  $admin_threads = 'unlimited',
  $admin_http = 'no',
  $admin_port = 8302,
  $admin_https = 'no',
  $admin_secure_port = 8303,
  $admin_acl = '127.'
) {

  if ($prefix != '/') {
    $home_path = "${prefix}/${name}"
    $instance_name = "janus_${name}"
  } else {
    $home_path = ''
    $instance_name = 'janus'
  }

  file { "${home_path}/etc/janus/janus.transport.http.cfg":
    ensure    => 'present',
    content   => template("${module_name}/transport/http.cfg"),
    owner     => '0',
    group     => '0',
    mode      => '0644',
    notify    => Service[$instance_name],
  }
}
