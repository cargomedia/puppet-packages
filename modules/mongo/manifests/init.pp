class mongo {

  user {'mongodb':
    ensure => present,
    system => true,
  }

  apt::source {'mongodb':
    entries => [
      "deb http://downloads-distro.mongodb.org/repo/debian-sysvinit dist 10gen",
    ],
    keys => {
      'mongodb' => {
        'key' => '7F0CEB10',
        'key_server' => 'keyserver.ubuntu.com',
      }
    },
  }

}
