node default {

  class {'augeas': }

  $config = @("END"/L)
  foo=bar
  bar=1
  | END

  file { '/tmp/foo':
    ensure  => present,
    content => $config,
  }

  $changes = @("END"/L)
  set bar 42
  set baz 22
  | END

  augeas { 'config_foo':
    incl    => '/tmp/foo',
    lens    => 'Shellvars.lns',
    changes => $changes,
    require => File['/tmp/foo'],
  }
}
