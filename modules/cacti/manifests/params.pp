class cacti::params {

  $host = $::host ? {
    undef => 'localhost',
    default => $::host,
  }

  $domain = $::domain  ? {
    undef => 'localhost',
    default => $::domain,
  }

  $ipPrivateNetwork = $::ipPrivateNetwork ? {
    undef => '127.0.0.0/24',
    default => $::ipPrivateNetwork,
  }

  $dbHost = $::dbHost ? {
    undef => 'localhost',
    default => $::dbHost,
  }

  $dbPort = $::dbPort ? {
    undef => '3306',
    default => $::dbPort,
  }

  $dbName = $::dbName ? {
    undef => 'cacti',
    default => $::dbName,
  }

  $dbUser = $::dbUser ? {
    undef => 'cacti',
    default => $::dbUser,
  }

  $dbPassword = $::dbPassword ? {
    undef => '',
    default => $::dbPassword,
  }

  $dbSenseUser = $::dbSenseUser ? {
    undef => '',
    default => $::dbSenseUser,
  }

  $dbSensePassword = $::dbSensePassword ? {
    undef => '',
    default => $::dbSensePassword,
  }

  $sshPublicKey = $::sshPublicKey ? {
    undef => 'No key defined',
    default => $::sshPublicKey,
  }

  $storageLvmName = $::storageLvmName ? {
    undef => '',
    default => $::storageLvmName,
  }

  $username = $::username ? {
    undef => 'cacti',
    default => $::username,
  }

  $groupname = $::groupname ? {
    undef => 'cacti',
    default => $::groupname,
  }
}
