define nginx::resource::upstream (
  $ensure = present,
  $members,
  $upstream_cfg_append = undef
) {
  File {
    owner => 'root',
    group => 'root',
    mode  => '0644',
  }

  $fileIfPresent = $ensure ? {present => file, default => $ensure}
  file {"/etc/nginx/conf.d/${name}-upstream.conf":
    ensure => $fileIfPresent,
    content  => template("${module_name}/conf.d/upstream.erb"),
    notify   => Class['nginx::service'],
  }
}
