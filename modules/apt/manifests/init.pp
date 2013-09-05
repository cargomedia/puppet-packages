class apt {

  include 'apt::update'

  package { 'apt':
    ensure => present
  }
  ->
  file { "/etc/apt/sources.list.d/":
    ensure => directory,
    owner   => '0',
    group   => '0',
    mode    => '0755',
  }

  file { '/etc/apt/sources.list':
    ensure => file,
    group => '0',
    owner => '0',
    mode => '0644',
    content => template("${module_name}/sources-squeeze"),
    notify => Exec['apt_update']
  }
}
