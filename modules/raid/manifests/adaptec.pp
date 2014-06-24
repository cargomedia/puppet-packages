class raid::adaptec {

  require 'unzip'
  require 'apt::source::cargomedia'
  require 'raid::hwraid-le-vert'

  package {'arcconf':
    ensure => present,
    require => Class['apt::source::cargomedia'],
  }
  ->

  package {'aacraid-status':
    ensure => present,
    require => Class['raid::hwraid-le-vert'],
  }
  ->

  service {'aacraid-statusd':
    hasstatus => false,
  }

  @monit::entry {'aacraid-statusd':
    content => template('raid/adaptec/monit'),
    require => Service['aacraid-statusd'],
  }

  file {'/usr/local/sbin/arcconf-write-cache-on-devices.pl':
    ensure => file,
    content => template('raid/adaptec/arcconf-write-cache-on-devices.pl'),
    owner => '0',
    group => '0',
    mode => '0755',
  }
  ->

  helper::script {'set hard drive write cache off if adaptec raid':
    content => template('raid/adaptec/set-write-cache-off.sh'),
    unless => 'test "$(/usr/local/sbin/arcconf-write-cache-on-devices.pl)" = ""',
    require => Package['arcconf'],
  }
}
