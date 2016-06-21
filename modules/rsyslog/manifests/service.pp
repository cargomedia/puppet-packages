class rsyslog::service {

  require 'rsyslog'

  service { 'rsyslog':
    enable  => true,
    require => Package['rsyslog'],
  }
}
