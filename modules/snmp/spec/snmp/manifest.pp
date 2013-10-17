node default {

  class {'snmp':
    views     => ['view system included  .iso.org.dod.internet.mgmt.mib-2.system'],
    disks     => ['disk /raid'],
    ip        => '127.0.0.1',
    community => 'fuckbook'
  }
}
