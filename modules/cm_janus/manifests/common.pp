class cm_janus::common {

  user { 'cm-janus':
    ensure  => present,
    system  => true,
  }

  package { 'cm-janus':
    ensure   => $version,
    provider => 'npm',
  }
}
