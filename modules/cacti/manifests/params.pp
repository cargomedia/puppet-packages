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

  $deployDir = $::deployDir  ? {
    undef => undef,
    default => $::deployDir,
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

  $htpasswd = $::htpasswd ? {
    undef => undef,
    default => $::htpasswd,
  }

  $sshPrivateKey = $::sshPrivateKey ? {
    undef => 'No private key',
    default => $::sshPrivateKey,
  }

  $sslPem = $::sslPem ? {
    undef => 'No ssl key',
    default => $::sslPem,
  }

  $userId = $::userId ? {
    undef => 2001,
    default => $::userId,
  }

  $groupId = $::groupId ? {
    undef => 2001,
    default => $::groupId,
  }
}
