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

  @bipbip::entry { 'raid-hpssacli':
    plugin  => 'command-status',
    options => {
      command      => '/usr/local/sbin/hpssacli-status 1>/dev/null',
      metric_group => 'raid',
    },
    require => File['/usr/local/sbin/hpssacli-status'],
  }
}
