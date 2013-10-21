node default {

  puppet::module {'puppetlabs-stdlib':}

  class {'cacti::server':
    ipPrivateNetwork  => '127.0.0.0/24',
    dbName            => 'cacti',
    dbUser            => 'cacti',
    dbPassword        => 'passwd',
    dbSenseUser       => 'cacti-sense',
    dbSensePassword   => 'passwd',
    sshPublickKey     => 'No key',
    storageLvmName    => '/dev/vg01/storage01',
  }
}
