node default {

  user { 'bob':
    ensure => present,
  }

  class { 'lightdm::autologin':
    user    => 'bob',
  }

}
