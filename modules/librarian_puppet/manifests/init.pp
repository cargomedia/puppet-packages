class librarian_puppet(
  $version = '2.2.1'
) {

  # Workaround for https://github.com/rodjek/librarian-puppet/issues/330
  ruby::gem { 'activesupport':
    ensure => '4.2.5',
  }
  ->

  ruby::gem { 'librarian-puppet':
    ensure => $version,
  }

}
