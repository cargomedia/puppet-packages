class nginx (
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
  $log_format                    = $nginx::params::nx_log_format,
  $access_log                    = $nginx::params::nx_access_log,
  $confd_purge                   = $nginx::params::nx_confd_purge,
  $server_names_hash_bucket_size = $nginx::params::nx_server_names_hash_bucket_size
  $server_names_hash_max_size    = $nginx::params::nx_server_names_hash_max_size
) inherits nginx::params {

  include 'nginx::bipbip_entry'

  class { 'nginx::package':
    notify => Class['nginx::service'],
  }

  class { 'nginx::config':
    daemon_user                   => $daemon_user,
    worker_processes              => $worker_processes,
    worker_connections            => $worker_connections,
    worker_rlimit_nofile          => $worker_rlimit_nofile,
    proxy_set_header              => $proxy_set_header,
    keepalive_timeout             => $keepalive_timeout,
    confd_purge                   => $confd_purge,
    server_tokens                 => $server_tokens,
    send_timeout                  => $send_timeout,
    client_max_body_size          => $client_max_body_size,
    client_body_timeout           => $client_body_timeout,
    client_header_timeout         => $client_header_timeout,
    log_format                    => $log_format,
    access_log                    => $access_log,
    server_names_hash_bucket_size => $server_names_hash_bucket_size,
    server_names_hash_max_size    => $server_names_hash_max_size,
    require                       => Class['nginx::package'],
    notify                        => Class['nginx::service'],
  }

  class { 'nginx::service': }

}
