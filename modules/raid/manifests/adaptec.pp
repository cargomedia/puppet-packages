class raid::adaptec {

  require 'hwraid-le-vert'

  package {'arcconf':
    ensure => present,
    require => Class['hwraid-le-vert'],
  }
  ->

  package {'aacraid-status':
    ensure => present
  }
  ->

  service {'aacraid-statusd':
    hasstatus => false,
  }

  @monit::entry {'aacraid-statusd':
    content => template('raid/adaptec/monit'),
    require => Service['aacraid-statusd'],
  }

  helper::script {'set hard drive write cache off if adaptec raid':
    content => template('raid/adaptec/set-write-cache-off.sh'),
    unless => 'false',
    require => Package['arcconf'],
  }
}
