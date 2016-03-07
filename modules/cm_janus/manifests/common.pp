class cm_janus::common (
  $version = latest
) {

  user { 'cm-janus':
    ensure  => present,
    system  => true,
  }

  package { 'cm-janus':
    ensure   => $version,
    provider => 'npm',
  }
}
