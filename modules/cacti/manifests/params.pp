class cacti::params {

  $resourceDir = $::resourceDir ? {
    undef => '/usr/share/cacti',
    default => $::resourceDir,
  }

  $scriptDir = $::scriptDir ? {
    undef => "${resourceDir}/site/scripts",
    default => $::scriptDir,
  }

  $templateDir = $::templateDir ? {
    undef => "${resourceDir}/templates",
    default => $::scriptDir,
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
    undef => 'cacti',
    default => $::dbPassword,
  }

  $dbSenseUser = $::dbSenseUser ? {
    undef => 'cacti-sense',
    default => $::dbSenseUser,
  }

  $dbSensePassword = $::dbSensePassword ? {
    undef => 'cacti',
    default => $::dbSensePassword,
  }

  $sshPublicKey = $::sshPublicKey ? {
    undef => template('cacti/etc/id_rsa'),
    default => $::sshPublicKey,
  }

  $sslPem = $::sslPem ? {
    undef => 'No ssl key',
    default => $::sslPem,
  }

  $userName = $::userName ? {
    undef => 'cacti',
    default => $::userName,
  }

  $userId = $::userId ? {
    undef => 2001,
    default => $::userId,
  }

  $groupName = $::groupName ? {
    undef => 'cacti',
    default => $::groupName,
  }

  $groupId = $::groupId ? {
    undef => 2001,
    default => $::groupId,
  }
}
