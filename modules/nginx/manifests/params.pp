class nginx::params {
  $nx_temp_dir = '/tmp'
  $nx_run_dir  = '/var/nginx'

  $nx_daemon_user           = 'nginx'
  $nx_access_log            = 'off'
  $nx_logdir                = '/var/log/nginx'
  $nx_pid                   = '/var/run/nginx.pid'
  $nx_conf_dir              = '/etc/nginx'
  $nx_confd_purge           = true
  $nx_worker_processes      = $::processorcount
  $nx_worker_connections    = 10000
  $nx_worker_rlimit_nofile  = 20000
  $nx_sendfile              = 'on'
  $nx_keepalive_timeout     = 30
  $nx_server_tokens         = 'off'
  $nx_gzip                  = 'on'
  $nx_send_timeout          = '10'

  $nx_client_body_timeout     = '10'
  $nx_client_header_timeout   = '10'
  $nx_client_max_body_size    = '10M'

  $nx_proxy_set_header        = [
    'Host $host', 'X-Real-IP $remote_addr',
    'X-Forwarded-For $proxy_add_x_forwarded_for',
  ]

  $nx_proxy_connect_timeout   = '60'
  $nx_proxy_send_timeout      = '60'
  $nx_proxy_read_timeout      = '60'

  $nx_upstream_ip_hash        = false
}
