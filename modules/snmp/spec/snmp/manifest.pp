node default {

  class {'apt':
    before => Class['snmp'],
  }

  class {'snmp':
    views             => ['view system  included .iso.org.dod.internet.mgmt.mib-2.system'],
    disks             => ['disk /raid'],
    communityNetwork  => '127.0.0.0/24',
    communityName     => 'fuckbook',
  }

  require 'monit'
}
