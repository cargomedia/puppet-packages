node default {


  class { 'php5::extension::opcache':
    max_accelerated_files => 55,
  }

  if $::lsbmajdistrelease >= 8 {
    require 'php5'
  }
}
