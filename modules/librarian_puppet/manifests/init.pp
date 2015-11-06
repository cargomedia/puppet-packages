class librarian_puppet(
  $version = '2.2.1'
) {

  ruby::gem { 'librarian-puppet':
    ensure => $version,
  }

}
