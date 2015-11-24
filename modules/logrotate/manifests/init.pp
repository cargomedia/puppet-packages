class logrotate {

  require 'apt'

  file { '/etc/logrotate.conf':
    ensure  => file,
    content => template("${module_name}/logrotate.conf"),
    owner   => '0',
    group   => '0',
    mode    => '0644',
  }

  file { '/etc/logrotate.d':
    ensure => directory,
    owner  => '0',
    group  => '0',
    mode   => '0755',
  }

  package { 'logrotate':
    ensure  => present,
    provider => 'apt',
    require => File['/etc/logrotate.conf', '/etc/logrotate.d'],
  }
}
