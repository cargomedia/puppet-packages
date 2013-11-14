class nginx::service(
  $service_restart     = $nginx::params::nx_service_restart
) {
  exec {'rebuild-nginx-vhosts':
    command     => "/bin/cat ${nginx::params::nx_temp_dir}/nginx.d/* > ${nginx::params::nx_conf_dir}/conf.d/vhost_autogen.conf",
    refreshonly => true,
    unless	=> "/usr/bin/test ! -f ${nginx::params::nx_temp_dir}/nginx.d/*",
    subscribe   => File["${nginx::params::nx_temp_dir}/nginx.d"],
  }
  service {'nginx':
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
    subscribe  => Exec['rebuild-nginx-vhosts'],
  }
}
