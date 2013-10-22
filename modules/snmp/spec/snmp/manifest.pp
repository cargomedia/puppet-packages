node default {

  class {'apt':
    before => Class['snmp'],
  }

  class {'snmp':
    views     => ['view system  included .iso.org.dod.internet.mgmt.mib-2.system'],
    disks     => ['disk /raid'],
    iphost    => '127.0.0.1',
    ipnetwork => '127.0.0.0/24',
    community => 'fuckbook',
  }
}
