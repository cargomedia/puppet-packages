node default {

  service { 'foo': }

  file{ '/tmp/bar':
    ensure  => file,
    content => template('sysvinit/spec/script/bar'),
    owner   => '0',
    group   => '0',
    mode    => '0755',
  }
  ->

  sysvinit::script{ 'foo':
    content   => template('sysvinit/spec/script/foo'),
  }
}
