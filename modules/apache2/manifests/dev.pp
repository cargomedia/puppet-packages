class apache2::dev {
  require 'package_manager'

  package{ ['apache2-threaded-dev']:
    ensure => present,
  }
}
