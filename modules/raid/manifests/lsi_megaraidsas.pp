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

  @bipbip::entry { 'raid-lsi':
    plugin  => 'command-status',
    options => {
      command => '/usr/local/sbin/megaraidsas-status 1>/dev/null',
    },
    require => File['/usr/local/sbin/megaraidsas-status'],
  }
}
