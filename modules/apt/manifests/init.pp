class apt {

  package { 'apt':
    ensure => present
  }

  file { "/etc/apt/sources.list.d/":
    ensure => directory,
    owner   => '0',
    group   => '0',
    mode    => '0755',
  }

}
