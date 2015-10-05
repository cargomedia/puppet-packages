class raid::sas2ircu {

  require 'raid::hwraid_le_vert'

  file { '/etc/default/sas2ircu-statusd':
    ensure  => file,
    content => template("${module_name}/sas2ircu/config"),
    owner   => '0',
    group   => '0',
    mode    => '0644',
    notify  => Service['sas2ircu-statusd'],
  }
  ->

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
