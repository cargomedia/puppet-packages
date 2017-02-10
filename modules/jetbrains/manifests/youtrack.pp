class jetbrains::youtrack (
  $host,
  $ssl_cert,
  $ssl_key,
  $version = '2017.1',
  $build   = '30867',
  $port    = 8081,
) {

  jetbrains::application { 'youtrack':
    host         => $host,
    ssl_cert     => $ssl_cert,
    ssl_key      => $ssl_key,
    version      => $version,
    build        => $build,
    port         => $port,
    download_url => "https://download.jetbrains.com/charisma/youtrack-${version}.${build}.zip",
    config       => template("${module_name}/youtrack.config"),
  }
}
