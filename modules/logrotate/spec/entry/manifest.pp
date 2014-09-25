node default {

  user {'bar':}

  file {['/var/log/bar', '/var/log/foo']:
    ensure => directory,
  }
  ->

  file { ['/var/log/foo_bar.log', '/var/log/foo/foo.log', '/var/log/bar_foo.log', '/var/log/bar/bar.log']:
    ensure => file,
  }
  ->

  logrotate::entry {'foo':
    file_patterns => ['/var/log/foo/*.log', '/var/log/foo_bar.log'],
    commands => [
      'create 640',
      'rotate 14',
      'compress',
      'daily',
      'delaycompress',
      'notifyempty'
    ]
  }

  logrotate::entry {'bar':
    file_patterns => ['/var/log/bar/*.log', '/var/log/bar_foo.log'],
    commands => [
      'create 640 bar bar',
      'rotate 4',
      'compress',
      'monthly',
    ]
  }

}
