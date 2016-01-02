node default {

  user { 'bob':
    ensure => present,
  }

  class { 'lightdm::config::autologin':
    user    => 'bob',
  }

}
