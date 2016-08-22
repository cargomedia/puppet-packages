class snmp (
  $views      = [],
  $disks      = [],
  $communityNetwork   = '127.0.0.0/24',
  $communityName      = 'public'
) {

  require 'apt'

  file { '/etc/snmp':
    ensure  => directory,
    owner   => '0',
    group   => '0',
    mode    => '0644',
  }

  file { '/etc/snmp/snmpd.conf':
    ensure  => file,
    content => template("${module_name}/snmpd.conf"),
    owner   => '0',
    group   => '0',
    mode    => '0644',
    before  => Package['snmpd'],
  }

  file { '/etc/default/snmpd':
    ensure  => file,
    content => template("${module_name}/default"),
    owner   => '0',
    group   => '0',
    mode    => '0644',
    before  => Package['snmpd'],
  }

  package { 'snmp':
    ensure   => present,
    provider => 'apt',
  }
  ->

  package { 'snmpd':
    ensure   => present,
    provider => 'apt',
  }

  if $::facts['lsbdistcodename'] == 'wheezy' {
    @monit::entry { 'snmpd':
      content => template("${module_name}/monit"),
      require => Package['snmpd'],
    }
  }

}
