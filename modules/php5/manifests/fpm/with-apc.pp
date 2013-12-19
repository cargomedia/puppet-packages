define php5::fpm::with-apc($host, $port) {

  @bipbip::entry {$name:
    plugin => 'fastcgi-php-apc',
    options => {
      'host' => $host,
      'port' => $port,
    }
  }

}
