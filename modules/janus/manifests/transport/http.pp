class janus::transport::http(
  $base_path = '/janus',
  $threads = 'unlimited',
  $http = 'yes',
  $port = 8300,
  $https = 'no',
  $secure_port = 8301,
  $acl = '127.,192.168.0.',
  $admin_base_path = '/admin',
  $admin_threads = 'unlimited',
  $admin_http = 'no',
  $admin_port = 8302,
  $admin_https = 'no',
  $admin_secure_port = 8303,
  $admin_acl = '127.,192.168.0.'
) {

  file { '/etc/janus/janus.transport.http.cfg':
    ensure    => 'present',
    content   => template("${module_name}/transport/http.cfg"),
    owner     => '0',
    group     => '0',
    mode      => '0644',
    notify    => Service['janus'],
  }
  ->

  janus::transport { $name: }
}
