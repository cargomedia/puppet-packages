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
    members => ['upstream:8043'],
  }

  cm::reverse_proxy { 'foobar':
    ssl_cert => template('cm/spec/spec-ssl.pem'),
    ssl_key  => template('cm/spec/spec-ssl.key'),
    upstream_options => {
      name  => $upstream1_name,
      ssl   => false,
    }
  }

  cm::reverse_proxy { 'alicebob':
    ssl_cert => template('cm/spec/spec-ssl.pem'),
    ssl_key  => template('cm/spec/spec-ssl.key'),
    upstream_options => {
      name   => $upstream2_name,
    },
  }

  nginx::resource::vhost { 'destination1':
    server_name => ['upstream'],
    listen_port => 8040,
    www_root    => '/var/www1/',
    require     => File['/var/www1/index.html'],
  }

  nginx::resource::vhost { 'destination2':
    server_name => ['upstream'],
    listen_port => 8043,
    ssl         => true,
    ssl_port    => 8043,
    ssl_cert    => template('cm/spec/spec-ssl.pem'),
    ssl_key     => template('cm/spec/spec-ssl.key'),
    www_root    => '/var/www2/',
    require     => File['/var/www2/index.html'],
  }
}
