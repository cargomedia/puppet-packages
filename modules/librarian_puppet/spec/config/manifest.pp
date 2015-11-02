node default {

  require 'librarian_puppet'

  file { ['/tmp/dir1', '/tmp/dir2']:
    ensure => directory,
  }

  librarian_puppet::config { 'config master-local':
    key   => 'master-local',
    value => '3',
    path  => '/tmp/dir1',
  }

  librarian_puppet::config { 'config master-global':
    key   => 'master-global',
    value => 'false',
  }

  librarian_puppet::config { 'config slave1':
    key   => 'slave',
    value => '22',
    path  => '/tmp/dir1',
  }

  librarian_puppet::config { 'config slave2':
    key   => 'slave',
    value => '33',
    path  => '/tmp/dir2',
  }

  librarian_puppet::config { 'config slave3':
    key   => 'slave',
    value => '88',
  }

}

