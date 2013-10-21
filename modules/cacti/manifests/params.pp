class cacti::params {

  $ipPrivateNetwork = $::ipPrivateNetwork ? {
    undef => '',
    default => $::ipPrivateNetwork,
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
