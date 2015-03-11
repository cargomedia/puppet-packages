node default {

  class { 'apt::update':
    max_cache_age => 99999999999999999,
  }

  package { 'less':
    ensure => installed
  }

}
