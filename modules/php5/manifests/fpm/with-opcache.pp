define php5::fpm::with-opcache($host, $port) {

  @bipbip::entry {"${name}-opcache":
    plugin => 'fastcgi-php-opcache',
    options => {
      'host' => $host,
      'port' => $port,
    }
  }

}
