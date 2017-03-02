node default {

  host { 'ssl.backend':
    host_aliases => [
      'ssl.upfront', 'plain.text.middle' ],
    ip           => '127.0.0.1',
  }

  file { '/var/webroot':
    ensure => directory;
    '/var/webroot/index.html':
      ensure  => file,
      content => '** This is the final destination<br/>';
  }

  cm::reverse_proxy { 'ssl.upfront':
    ssl_cert          => template('cm/spec/spec-ssl.pem'),
    ssl_key           => template('cm/spec/spec-ssl.key'),
    upstream_members  => ['plain.text.middle:8081'],
    upstream_protocol => 'http',
  }

  cm::reverse_proxy { 'plain.text.middle':
    listen_port       => 8081,
    ssl_port          => 0,
    upstream_members  => ['ssl.backend:8443'],
    upstream_protocol => 'https',
  }


  nginx::resource::vhost { 'ssl.backend':
    server_name => ['ssl.backend'],
    listen_port => 8443,
    ssl         => true,
    ssl_port    => 8443,
    ssl_cert    => template('cm/spec/spec-ssl.pem'),
    ssl_key     => template('cm/spec/spec-ssl.key'),
    www_root    => '/var/webroot/',
    require     => File['/var/webroot/index.html'],
  }
}
