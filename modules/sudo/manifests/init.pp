class sudo {

  require 'apt'

  package { 'sudo':
    ensure   => present,
    provider => 'apt',
  }

  sudo::config { 'mail-no-user-off':
    content => 'mail_no_user off'
  }
}
