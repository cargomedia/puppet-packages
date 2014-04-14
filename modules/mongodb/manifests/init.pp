class mongodb {

  user {'mongodb':
    ensure => present,
    system => true,
  }

  file {'/var/lib/mongodb':
    ensure  => directory,
    mode    => '0655',
    owner   => 'mongodb',
    group   => 'mongodb';
  }

  apt::source {'mongodb':
    entries => [
      'deb http://downloads-distro.mongodb.org/repo/debian-sysvinit dist 10gen',
    ],
    keys => {
      'mongodb' => {
        'key' => '7F0CEB10',
        'key_server' => 'keyserver.ubuntu.com',
      }
    },
  }

}
