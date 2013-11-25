class cacti (
  $userId  = $cacti::params::userId,
  $groupId  = $cacti::params::groupId
) inherits cacti::params {

  $userName = 'cacti'
  $groupName = 'cacti'

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
