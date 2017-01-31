define nginx::resource::upstream (
  $members,
  $upstream_cfg_append = undef
) {
  File {
    owner => 'root',
    group => 'root',
    mode  => '0644',
  }

  file { "/etc/nginx/conf.d/${name}-upstream.conf":
    ensure   => file,
    content  => template("${module_name}/conf.d/upstream.erb"),
    notify   => Class['nginx::service'],
  }
}
