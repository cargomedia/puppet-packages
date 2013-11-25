class php5::extension::ssh2 {

  require 'php5'

  package {'libssh2-php':
    ensure => present,
  }
}
