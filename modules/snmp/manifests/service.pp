class snmp::service($interface = undef) {

  $network = hiera_hash('network')

  if $network['interfaces'] {
    if $network['interfaces'][$interface] {

      class {'snmp':
        iphost => $network['interfaces'][$interface]['ipaddr'],
        ipnetwork => $network['interfaces'][$interface]['network']
      }
    }
  }
}
