class foreman::initd {

  require 'foreman'

  ruby::gem {'foreman-export-initd':
    ensure => present,
  }
}
