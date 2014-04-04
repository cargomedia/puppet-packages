class librarian_puppet(
  $version = '0.9.17'
) {

  ruby::gem {'librarian-puppet':
    ensure => $version,
  }

}
