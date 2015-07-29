node default {

  file { '/tmp/foo':
    ensure  => 'directory',
    owner   => 'root',
  }

  ->
  nodejs::package { 'async':
    path    => '/tmp/foo',
    version => 'latest',
  }
}
