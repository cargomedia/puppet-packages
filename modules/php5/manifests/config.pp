define php5::config(
  $memory_limit = '512M',
  $display_errors = false
) {

  file {$name:
    ensure => file,
    content => template('php5/config/php.ini'),
    owner => '0',
    group => '0',
    mode => '0644',
  }
}
