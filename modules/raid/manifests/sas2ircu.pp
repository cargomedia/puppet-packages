class raid::sas2ircu {

  require 'apt'
  require 'apt::source::cargomedia'
  require 'python'

  package { 'sas2ircu':
    provider => 'apt',
  }

  file { '/usr/local/sbin/sas2ircu-status':
    ensure  => file,
    content => template("${module_name}/sas2ircu/sas2ircu-status"),
    owner   => '0',
    group   => '0',
    mode    => '0755',
    require => Package['sas2ircu'],
  }

  @bipbip::entry { 'raid-sas':
    plugin  => 'command_status',
    command => '/usr/local/sbin/sas2ircu-status',
    require => File['/usr/local/sbin/sas2ircu-status'],
  }
}
