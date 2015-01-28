define php5::fpm::with_apc($host, $port) {

  @bipbip::entry { "${name}-apc":
    plugin  => 'fastcgi-php-apc',
    options => {
      'host' => $host,
      'port' => $port,
    }
  }

}
