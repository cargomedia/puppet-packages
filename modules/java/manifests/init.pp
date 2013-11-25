class java {

  apt::source {'java7':
    entries => [
      'deb http://ppa.launchpad.net/webupd8team/java/ubuntu precise main',
      'deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu precise main'
    ],
    keys => {
      'java7' => {
        'key' => 'EEA14886',
        'key_server' => 'keyserver.ubuntu.com',
      }
    }
  }
  ~>

  exec {'debconf for java':
    command => 'echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
                echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections',
    refreshonly => true,
    path => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
  }
  ->

  package {'oracle-java7-installer':
    ensure => present,
  }
}
