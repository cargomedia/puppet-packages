class cacti (
  $userName   = $cacti::params::userName,
  $userId  = $cacti::params::userId,
  $groupName  = $cacti::params::groupName,
  $groupId  = $cacti::params::groupId
) inherits cacti::params {

  group {$groupName:
    ensure => present,
    gid => $groupId,
  }
  ->

  user {$userName:
    ensure  => present,
    gid     => $groupName,
    uid     => $userId,
    require => Group[$groupName],
  }
}
