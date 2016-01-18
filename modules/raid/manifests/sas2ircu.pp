class raid::sas2ircu {

  require 'apt'
  require 'apt::source::cargomedia'

  package { 'sas2ircu':
    provider => 'apt',
  }

  @monit::entry { 'raid-sas':
    content => template("${module_name}/sas2ircu/monit"),
    require => Package['sas2ircu'],
  }
}
