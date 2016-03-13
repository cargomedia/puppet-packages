class ruby::gem::bundler (
  $version = '1.10.5', # Compatible with Vagrant 1.7.3
) {

  ruby::gem { 'bundler':
    ensure => $version,
  }
}
