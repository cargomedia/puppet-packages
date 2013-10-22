node default {

  puppet::module {'puppetlabs-stdlib':}

  class {'cacti::server':
    host              => 'localhost',
    domain            => 'localhost',
    ipPrivateNetwork  => '127.0.0.0/24',
    dbHost            => 'localhost',
    dbPort            => '3306',
    dbName            => 'cacti',
    dbUser            => 'cacti',
    dbPassword        => 'passwd',
    dbSenseUser       => 'cacti-sense',
    dbSensePassword   => 'passwd',
    sshPublickKey     => 'No key',
    storageLvmName    => '/dev/vg01/storage01',
  }
}
