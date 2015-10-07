node default {

  $domain_xxx = 'foo.xxx'
  $upstream_name = 'nine-five-nine-five'

  host { $domain_xxx:
    host_aliases => [
      "www.${domain_xxx}",
      'bar.xxx', 'baz.xxx' ],
    ip           => '127.0.0.1',
  }

  file { '/var/www':
    ensure => directory,
  }

  file { '/var/www/index.html':
    ensure  => file,
    content => 'foobar',
  }

  cm::upstream::proxy { $upstream_name:
    members => ['bar.xxx:9595'],
  }

  cm::reverse_proxy { $domain_xxx:
    upstream_name          => $upstream_name,
    ssl_to_backend         => false,
  }

  nginx::resource::vhost { 'proxy-destination':
    server_name         => ['bar.xxx'],
    listen_port         => 9595,
    www_root            => '/var/www/',
    require             => File['/var/www/index.html'],
  }
}
