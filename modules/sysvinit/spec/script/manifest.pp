node default {

  file{'/tmp/bar':
    ensure => file,
    content => template('sysvinit/spec/script/bar'),
    owner => '0',
    group => '0',
    mode => '0755',
  }
  ->

  sysvinit::script{'foo':
    init_file_content => template('sysvinit/spec/script/foo'),
  }
}
