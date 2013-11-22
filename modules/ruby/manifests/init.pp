class ruby {

  package {['ruby', 'ruby-dev', 'ri']:
    ensure => present,
  }
}
