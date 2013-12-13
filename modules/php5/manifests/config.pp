define php5::config() {

  file {$name:
    ensure => file,
    content => template('php5/config/php.ini'),
    owner => '0',
    group => '0',
    mode => '0644',
  }
}
