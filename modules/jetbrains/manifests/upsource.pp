class jetbrains::upsource (
  $host,
  $ssl_cert,
  $ssl_key,
  $version = '2017.2',
  $build   = '2398',
  $port    = 8082,
  $hub_url = undef,
) {

  jetbrains::application { 'upsource':
    host          => $host,
    ssl_cert      => $ssl_cert,
    ssl_key       => $ssl_key,
    version       => $version,
    build         => $build,
    port          => $port,
    download_url  => "https://download.jetbrains.com/upsource/upsource-${version}.${build}.zip",
    config        => file("${module_name}/upsource.config"),
    hub_url       => $hub_url,
    limit_memlock => 'unlimited',
    limit_nofile  => 500000,
    limit_nproc   => 32768,
    limit_as      => 'unlimited',
  }

  ensure_packages(['libxrender1', 'libxext6'], { provider => 'apt' })
}
