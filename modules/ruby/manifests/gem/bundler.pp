class ruby::gem::bundler {

  ruby::gem { 'bundler':
    ensure => latest,
  }
}
