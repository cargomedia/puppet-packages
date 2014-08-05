class librarian_puppet(
  $version = '1.3.0'
) {

  ruby::gem {'librarian-puppet':
    ensure => $version,
  }

}
