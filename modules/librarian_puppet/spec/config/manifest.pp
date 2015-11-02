node default {

  require 'librarian_puppet'

  librarian_puppet::config { 'config master-local':
    key   => 'master-local',
    path  => '/tmp',
    value => '3',
  }

  librarian_puppet::config { 'config master-global':
    key   => 'master-global',
    value => false,
  }

  librarian_puppet::config { 'config slave':
    key   => 'slave',
    value => 22,
    path  => '/tmp',
  }

  librarian_puppet::config { 'config slave2':
    key   => 'slave',
    value => 88,
  }

}

