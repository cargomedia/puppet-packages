node default {

  class { 'apt::update':
    max_cache_age => 3*3600,
  }

}
