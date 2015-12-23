node default {

  user { 'bob':
    ensure => present,
    uid    => 1234,
  }

  lightdm::xsession { 'my-session':
    exec => '/bin/true',
  }

}
