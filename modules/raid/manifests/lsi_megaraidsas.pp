class raid::lsi_megaraidsas {

  require 'apt'
  require 'apt::source::cargomedia'
  require 'python'

  package { 'storcli':
    provider => 'apt',
  }

  file { '/usr/local/sbin/megaraidsas-status':
    ensure  => file,
    content => template("${module_name}/lsi_megaraidsas/megaraidsas-status"),
    owner   => '0',
    group   => '0',
    mode    => '0755',
    require => Package['storcli'],
  }

  @monit::entry { 'raid-lsi':
    content => template("${module_name}/lsi_megaraidsas/monit"),
    require => File['/usr/local/sbin/megaraidsas-status'],
  }
}
