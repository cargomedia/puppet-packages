class librarian_puppet(
  $version = '0.9.13'
) {

  ruby::gem {'librarian-puppet':
    ensure => $version,
  }

}
