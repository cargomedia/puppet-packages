class raid::adaptec {

  require 'unzip'
  require 'apt::source::cargomedia'
  require 'raid::hwraid_le_vert'

  package {'arcconf':
    ensure => present,
    require => Class['apt::source::cargomedia'],
  }
  ->

  package {'aacraid-status':
    ensure => present,
    require => Class['raid::hwraid_le_vert'],
  }
  ->

  service {'aacraid-statusd':
    hasstatus => false,
  }

  @monit::entry {'aacraid-statusd':
    content => template("${module_name}/adaptec/monit"),
    require => Service['aacraid-statusd'],
  }

  file {'/usr/local/sbin/arcconf-write-cache-on-devices.pl':
    ensure => file,
    content => template("${module_name}/adaptec/arcconf-write-cache-on-devices.pl"),
    owner => '0',
    group => '0',
    mode => '0755',
  }
  ->

  helper::script {'set hard drive write cache off if adaptec raid':
    content => template("${module_name}/adaptec/set-write-cache-off.sh"),
    unless => 'test "$(/usr/local/sbin/arcconf-write-cache-on-devices.pl)" = ""',
    require => Package['arcconf'],
  }
}
