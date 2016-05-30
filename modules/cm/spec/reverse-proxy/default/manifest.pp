node default {

  $upstream_name = 'nine-five-nine-five'

  host { 'proxy.xxx':
    host_aliases => ['bar.xxx'],
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

  cm::reverse_proxy { 'foo.xxx':
    ssl_cert         => template('cm/spec/spec-ssl.pem'),
    ssl_key          => template('cm/spec/spec-ssl.key'),
    upstream_options => {
      name        => $upstream_name,
      header_host => 'bar.xxx',
    }
  }

  nginx::resource::vhost { 'proxy-destination':
    server_name => ['bar.xxx'],
    listen_port => 9595,
    www_root    => '/var/www/',
    require     => File['/var/www/index.html'],
  }
}
