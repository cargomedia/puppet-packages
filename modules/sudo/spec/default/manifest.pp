node default {

  include 'sudo'

  user { 'foo':
    ensure => present,
  }

  @sudo::config { 'foo':
    content => 'foo ALL=NOPASSWD:ALL',
  }
}
