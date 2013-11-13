node default {

  class {'nginx':
    daemon_user           => 'nginx',
    worker_processes      => 6,
    worker_rlimit_nofile  => 20000,
    worker_connections    => 10000,
    server_tokens         => off,
    keepalive_timeout     => 30,
    access_log            => off,
    error_log             => on,
  }
}