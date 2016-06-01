node default {

  require 'php5::fpm'

  host { 'mock-domain-resolution':
    host_aliases => [
      'example1.com', 'www.example1.com', 'admin.example1.com', 'origin-www.example1.com',
      'example1-redirect1.com', 'example1-redirect2.com', 'example1-redirect2.com',
      'example2.com', 'www.example2.com', 'admin.example2.com', 'origin-www.example2.com',
      'example3.com', 'www.example3.com', 'admin.example3.com', 'origin-www.example3.com',
    ],
    ip           => '127.0.0.1',
  }

  # HTTPS with CDN and Redirect
  cm::vhost { 'example1.com':
    path       => '/tmp/app1',
    ssl_cert   => template('cm/spec/spec-ssl.pem'),
    ssl_key    => template('cm/spec/spec-ssl.key'),
    aliases    => ['www.example1.com', 'admin.example1.com'],
    cdn_origin => 'origin-www.example1.com',
    redirects  => ['example1-redirect1.com', 'example1-redirect2.com', 'example1-redirect2.com'],
  }

  # HTTPS without CDN
  cm::vhost { 'www.example2.com':
    path     => '/tmp/app2',
    ssl_cert => template('cm/spec/spec-ssl.pem'),
    ssl_key  => template('cm/spec/spec-ssl.key'),
    aliases  => [ 'example2.com', 'admin.example2.com' ],
  }

  # HTTP
  cm::vhost { 'www.example3.com':
    path       => '/tmp/app3',
    ssl_cert   => template('cm/spec/spec-ssl.pem'),
    ssl_key    => template('cm/spec/spec-ssl.key'),
    aliases    => [ 'example3.com', 'admin.example3.com' ],
    cdn_origin => 'origin-www.example3.com',
  }

  file { [
    '/tmp/app1', '/tmp/app1/public', '/tmp/app1/public/static',
    '/tmp/app2', '/tmp/app2/public', '/tmp/app2/public/static',
    '/tmp/app3', '/tmp/app3/public', '/tmp/app3/public/static',
  ]:
    ensure => directory,
  }

  file { [
    '/tmp/app1/public/index.php',
    '/tmp/app2/public/index.php',
    '/tmp/app3/public/index.php',
  ]:
    content => '<?php echo "Hello World!";',
  }

  file { [
    '/tmp/app1/public/static/file.txt',
    '/tmp/app2/public/static/file.txt',
    '/tmp/app3/public/static/file.txt',
  ]:
    content => 'My Data',
  }

}
