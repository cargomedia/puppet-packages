node default {

  require 'php5::fpm'

  host { 'www.example.com':
    ip => '127.0.0.1',
  }

  cm::vhost { 'www.example.com':
    path       => '/tmp/example'
  }

  file { ['/tmp/example', '/tmp/example/public']:
    ensure => directory
  }

  file { '/tmp/example/public/index.php':
    ensure  => file,
    content => '<?php echo "your ip: " . $_SERVER["REMOTE_ADDR"];'
  }

}
