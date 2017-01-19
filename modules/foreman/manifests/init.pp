class foreman(
  $version = '0.83.0',
) {

  ruby::gem { 'foreman':
    ensure => $version,
  }
}
