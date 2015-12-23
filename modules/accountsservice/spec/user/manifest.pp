node default {

  user { 'bob':
    ensure => present,
    uid    => 1234,
  }

  accountsservice::user { 'bob':
    xsession => 'my-session',
  }

}
