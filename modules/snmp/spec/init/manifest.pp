node default {

  class { 'snmp':
    views             => ['view system  included .iso.org.dod.internet.mgmt.mib-2.system'],
    disks             => ['/raid', '/foo'],
    communityNetwork  => '127.0.0.0/24',
    communityName     => 'fuboo',
  }

}
