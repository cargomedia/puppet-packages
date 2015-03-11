node default {

  include 'apt::update'

  package { 'less':
    ensure => installed
  }

}
