class raid::lsi-megaraidsas {

  require 'hwraid-le-vert'

  package {'arcconf':
    ensure => present,
    require => Class['hwraid-le-vert'],
  }
  ->

  package {'megaraid-status':
    ensure => present
  }
  ->

  service {'megaraidsas-statusd':
    hasstatus => false,
  }

  @monit::entry {'megaraidsas-statusd':
    content => template('raid/lsi-megaraidsas/monit'),
    require => Service['megaraidsas-statusd'],
  }
}
