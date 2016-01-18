class raid::lsi_megaraidsas {

  require 'python'

  file { '/usr/local/sbin/lsi-raid-status':
    ensure  => file,
    content => template("${module_name}/lsi_megaraidsas/lsi-raid-status"),
    owner   => '0',
    group   => '0',
    mode    => '0755',
  }

  @monit::entry { 'raid-lsi':
    content => template("${module_name}/lsi_megaraidsas/monit"),
    require => File['/usr/local/sbin/lsi-raid-status'],
  }
}
