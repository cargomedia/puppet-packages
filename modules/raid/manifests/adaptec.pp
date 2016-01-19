class raid::adaptec {

  require 'apt'
  require 'unzip'
  require 'apt::source::cargomedia'
  require 'python'

  package { 'arcconf':
    ensure   => present,
    provider => 'apt',
    require  => Class['apt::source::cargomedia'],
  }

  file { '/usr/local/sbin/aacraid-status':
    ensure  => file,
    content => template("${module_name}/adaptec/aacraid-status"),
    owner   => '0',
    group   => '0',
    mode    => '0755',
  }

  @monit::entry { 'raid-adaptec':
    content => template("${module_name}/adaptec/monit"),
    require => File['/usr/local/sbin/aacraid-status'],
  }

  file { '/usr/local/sbin/arcconf-write-cache-on-devices.pl':
    ensure  => file,
    content => template("${module_name}/adaptec/arcconf-write-cache-on-devices.pl"),
    owner   => '0',
    group   => '0',
    mode    => '0755',
  }
  ->

  helper::script { 'set hard drive write cache off if adaptec raid':
    content => template("${module_name}/adaptec/set-write-cache-off.sh"),
    unless  => 'test "$(/usr/local/sbin/arcconf-write-cache-on-devices.pl)" = ""',
    require => Package['arcconf'],
  }
}
