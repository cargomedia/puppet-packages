node default {

  host { 'foo.xxx':
    host_aliases => ['bar.xxx', 'baz.xxx'],
    ip           => '127.0.0.1',
  }

  file { '/var/www':
    ensure => directory,
  }

  file { '/var/www/index.html':
    ensure  => file,
    content => 'foobar',
  }

  cm::reverse_proxy { 'foo.xxx':
    redirects        => ['baz.xxx'],
    ssl_cert         => template('cm/spec/spec-ssl.pem'),
    ssl_key          => template('cm/spec/spec-ssl.key'),
    upstream_options => { members => ['baz.xxx:4433']},
  }

  nginx::resource::vhost { 'upstream-server':
    ssl         => true,
    listen_port => 4433,
    ssl_port    => 4433,
    ssl_cert    => template('cm/spec/spec-ssl.pem'),
    ssl_key     => template('cm/spec/spec-ssl.key'),
    www_root    => '/var/www/',
    require     => File['/var/www/index.html'],
  }
}
