node default {

  include 'nginx'
  include 'goreplay'

  nginx::resource::vhost { 'foo':
    server_name => ['localhost'],
    listen_port => 8081,
  }

  class { 'goreplay::unit':
    input    => 'raw :8081',
    output   => 'file ./traffic  -output-file-flush-interval 1s',
    duration => '5s',
    require  => Nginx::Resource::Vhost['foo'],
  }

  exec { 'random http request':
    provider => shell,
    command  => 'curl http://localhost:8081/foo 2>/dev/null',
    path     => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
    require  => [Nginx::Resource::Vhost['foo'],Service['nginx','goreplay']],
  }

  exec { 'another http request':
    provider => shell,
    command  => 'curl http://localhost:8081/bar 2>/dev/null',
    path     => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
    require  => [Nginx::Resource::Vhost['foo'],Service['nginx','goreplay']],
  }
}