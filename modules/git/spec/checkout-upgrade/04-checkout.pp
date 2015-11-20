node default {

  user { 'bob':
    ensure => present,
  }

  git::checkout { 'my checkout':
    repository => 'file:///tmp/repo',
    directory  => '/tmp/checkout',
    version    => 'tag2',
    user       => 'bob',
  }

}
