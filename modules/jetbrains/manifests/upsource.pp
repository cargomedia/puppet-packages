class jetbrains::upsource (
  $host,
  $ssl_cert,
  $ssl_key,
  $version = '3.5',
  $build   = '3616',
  $port    = 8082,
) {

  jetbrains::application { 'upsource':
    host         => $host,
    ssl_cert     => $ssl_cert,
    ssl_key      => $ssl_key,
    version      => $version,
    build        => $build,
    port         => $port,
    download_url => "https://download.jetbrains.com/upsource/upsource-${version}.${build}.zip"
  }

}
