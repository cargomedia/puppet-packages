class nginx::config(
  $daemon_user                   = $nginx::params::nx_daemon_user,
  $worker_processes              = $nginx::params::nx_worker_processes,
  $worker_connections            = $nginx::params::nx_worker_connections,
  $worker_rlimit_nofile          = $nginx::params::nx_worker_rlimit_nofile,
  $proxy_set_header              = $nginx::params::nx_proxy_set_header,
  $keepalive_timeout             = $nginx::params::nx_keepalive_timeout,
  $server_tokens                 = $nginx::params::nx_server_tokens,
  $send_timeout                  = $nginx::params::nx_send_timeout,
  $client_max_body_size          = $nginx::params::nx_client_max_body_size,
  $client_body_timeout           = $nginx::params::nx_client_body_timeout,
  $client_header_timeout         = $nginx::params::nx_client_header_timeout,
  $access_log                    = $nginx::params::nx_access_log,
  $confd_purge                   = $nginx::params::nx_confd_purge,
  $server_names_hash_bucket_size = $nginx::params::nx_server_names_hash_bucket_size
) inherits nginx::params {
  File {
    owner => 'root',
    group => 'root',
    mode  => '0644',
  }

  file { $nginx::params::nx_temp_dir:
    ensure => directory,
  }

  file { $nginx::params::nx_conf_dir:
    ensure => directory,
  }

  file { "${nginx::params::nx_conf_dir}/conf.d":
    ensure => directory,
  }
  if $confd_purge == true {
    File["${nginx::params::nx_conf_dir}/conf.d"] {
      ignore  => 'vhost_autogen.conf',
      purge   => true,
      recurse => true,
    }
  }

  file { $nginx::config::nx_run_dir:
    ensure => directory,
  }

  file { "${nginx::params::nx_conf_dir}/ssl":
    ensure => directory,
  }

  file { "${nginx::params::nx_conf_dir}/sites-enabled/default":
    ensure => absent,
  }

  file { "${nginx::params::nx_conf_dir}/nginx.conf":
    ensure  => file,
    content => template("${module_name}/conf.d/nginx.conf.erb"),
  }

  file { "${nginx::params::nx_conf_dir}/fastcgi_params":
    ensure  => file,
    content => template("${module_name}/fastcgi_params.erb"),
  }

  file { "${nginx::params::nx_conf_dir}/conf.d/proxy.conf":
    ensure  => file,
    content => template("${module_name}/conf.d/proxy.conf.erb"),
  }

  file { "${nginx::config::nx_temp_dir}/nginx.d":
    ensure  => directory,
    purge   => true,
    recurse => true,
  }
}
