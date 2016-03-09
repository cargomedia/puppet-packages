define janus::transport::http(
  $prefix = undef,
  $threads = 'unlimited',
  $http = 'yes',
  $http_base_path = '/janus',
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

  require 'janus::common'

  Janus::Server::Setup_dirs[$name] -> Janus::Transport::Http[$name]

  $instance_name = $prefix? {
    undef => 'janus',
    default => "janus_${name}"
  }

  $instance_base_dir = $prefix? {
    undef => '',
    default =>"${prefix}/${title}"
  }

  file { "${instance_base_dir}/usr/lib/janus/transports.enabled/libjanus_http.so":
    ensure    => link,
    target    => '/usr/lib/janus/transports/libjanus_http.so',
  }
  ->

  file { "${instance_base_dir}/etc/janus/janus.transport.http.cfg":
    ensure     => 'present',
    content    => template("${module_name}/transport/http.cfg"),
    owner      => '0',
    group      => '0',
    mode       => '0644',
    before     => Daemon[$instance_name],
    notify     => Service[$instance_name],
  }
}
