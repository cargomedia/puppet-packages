class librarian_puppet(
  $version = '2.2.1'
) {

  # Workaround for https://github.com/rodjek/librarian-puppet/issues/330
  package { 'libssl1.0.0':
    ensure => latest,
    provider => apt,
  }
  ->

  ruby::gem { 'activesupport':
    ensure => '4.2.5',
  }
  ->

  ruby::gem { 'librarian-puppet':
    ensure => $version,
  }

}
