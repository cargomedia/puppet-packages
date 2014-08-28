class raid::lsi_megaraidsas {

  require 'raid::hwraid_le_vert'

  package {'megaraid-status':
    ensure => present
  }
  ->

  service {'megaraidsas-statusd':
    hasstatus => false,
  }

  @monit::entry {'megaraidsas-statusd':
    content => template("${module_name}/lsi_megaraidsas/monit"),
    require => Service['megaraidsas-statusd'],
  }
}
