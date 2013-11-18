define nginx::resource::upstream (
  $ensure = 'present',
  $members,
  $ip_hash = $nginx::params::nx_upstream_ip_hash,
) {
  File {
    owner => 'root',
    group => 'root',
    mode  => '0644',
  }

  file {"/etc/nginx/conf.d/${name}-upstream.conf":
    ensure => $ensure ? {
      'absent'  => absent,
      default   => 'file',
    },
    content  => template('nginx/conf.d/upstream.erb'),
    notify   => Class['nginx::service'],
  }
}
