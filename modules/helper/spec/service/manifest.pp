node default {

  file{'/tmp/bar':
    ensure => file,
    content => template('helper/spec/service/bar'),
    owner => '0',
    group => '0',
    mode => '0755',
  }
  ->

  helper::service{'foo':
    init_file_content => template('helper/spec/service/foo'),
  }
}
