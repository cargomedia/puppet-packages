class cacti (
  $user_id  = $cacti::params::user_id,
  $group_id = $cacti::params::group_id
) inherits cacti::params {

  $user_name = $cacti::params::user_name
  $group_name = $cacti::params::group_name

  group {$group_name:
    ensure  => present,
    gid     => $group_id,
  }
  ->

  user {$user_name:
    ensure  => present,
    gid     => $group_name,
    uid     => $user_id,
  }

}
