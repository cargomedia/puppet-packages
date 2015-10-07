node default {

  $upstream1_name = 'foobar'
  $upstream2_name = 'alicebob'

  host { 'foobar':
    host_aliases => [
      'upstream', 'alicebob' ],
    ip           => '127.0.0.1',
  }

  file { ['/var/www1','/var/www2']:
    ensure => directory,
  }

  file { '/var/www1/index.html':
    ensure  => file,
    content => 'foobar',
  }

  file { '/var/www2/index.html':
    ensure  => file,
    content => 'alice and bob',
  }

  cm::upstream::proxy { $upstream1_name:
    members => ['upstream:8040'],
  }

  cm::upstream::proxy { $upstream2_name:
    members => ['upstream:8041'],
  }

  cm::reverse_proxy { 'foobar':
    upstream_name          => $upstream1_name,
    ssl_to_backend         => false,
  }

  cm::reverse_proxy { 'alicebob':
    upstream_name          => $upstream2_name,
    ssl_to_backend         => false,
  }

  nginx::resource::vhost { 'destination1':
    server_name         => ['upstream'],
    listen_port         => 8040,
    www_root            => '/var/www1/',
    require             => File['/var/www1/index.html'],
  }

  nginx::resource::vhost { 'destination2':
    server_name         => ['upstream'],
    listen_port         => 8041,
    www_root            => '/var/www2/',
    require             => File['/var/www2/index.html'],
  }
}
