node default {

  user { 'bob':
    ensure => present,
  }

  ->
  file { '/tmp/foo':
    ensure  => 'directory',
    owner   => 'bob',
  }

  ->
  nodejs::package { 'async':
    path    => '/tmp/foo',
    version => '1.3.0',
    user    => 'bob',
  }
}
