class cacti::params {

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
