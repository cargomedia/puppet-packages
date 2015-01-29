class ruby::gem::bundler ($version = 'present') {

  ruby::gem { 'bundler':
    ensure => $version,
  }
}
