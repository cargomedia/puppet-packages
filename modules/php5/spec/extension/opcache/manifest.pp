node default {

  class { 'php5::extension::opcache':
    max_accelerated_files => 555,
  }
}
