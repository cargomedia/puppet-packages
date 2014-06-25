class raid::lsi-megaraidsas {

  require 'raid::hwraid-le-vert'

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
