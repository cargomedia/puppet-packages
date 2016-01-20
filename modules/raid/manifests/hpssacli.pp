class raid::hpssacli {

  require 'apt'
  require 'apt::source::cargomedia'

  package { 'hpssacli':
    provider => 'apt',
  }

  file { '/usr/local/sbin/hpssacli-status':
    ensure  => file,
    content => template("${module_name}/hpssacli/hpssacli-status"),
    owner   => '0',
    group   => '0',
    mode    => '0755',
    require => Package['hpssacli'],
  }

  @monit::entry { 'raid-hpssacli':
    content => template("${module_name}/hpssacli/monit"),
    require => File['/usr/local/sbin/hpssacli-status'],
  }
}
