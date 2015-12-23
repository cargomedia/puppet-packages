node default {

  group { 'nopasswdlogin':
    ensure => present,
  }

  user { 'bob':
    ensure     => present,
    managehome => true,
    groups     => ['nopasswdlogin'],
  }

  class { 'chromium::kiosk':
    user => 'bob',
    url  => 'http://www.example.org',
  }

}
