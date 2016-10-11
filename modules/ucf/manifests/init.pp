class ucf {

  require 'apt'

  file { '/etc/ucf.conf':
    ensure  => file,
    content => template("${module_name}/ucf.conf"),
    owner   => '0',
    group   => '0',
    mode    => '0644',
    before  => Package['ucf'],
  }

  package { 'ucf':
    ensure   => present,
    provider => 'apt',
  }
}
