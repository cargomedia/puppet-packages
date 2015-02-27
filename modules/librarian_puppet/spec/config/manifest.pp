node default {

  require 'librarian_puppet'

  librarian_puppet::config { 'master-local':
    path  => '/tmp',
    value => '3',
  }

  librarian_puppet::config { 'master-global':
    value => false,
  }

  librarian_puppet::config { 'slave-local':
    path  => '/tmp',
    value => true,
  }

  librarian_puppet::config { 'slave-global':
    value => 88,
  }

}

