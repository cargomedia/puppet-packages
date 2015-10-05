class raid::sas2ircu {

  require 'raid::hwraid_le_vert'

  package { 'sas2ircu-status':
    ensure => present
  }
  ->

  service { 'sas2ircu-statusd':
    hasstatus => false,
    enable    => true,
  }

  @monit::entry { 'sas2ircu-statusd':
    content => template("${module_name}/sas2ircu/monit"),
    require => Service['sas2ircu-statusd'],
  }
}
