class cacti (
  $username   = $cacti::params::username,
  $groupname  = $cacti::params::groupname
) inherits cacti::params {

  group {$groupname:
    ensure => present,
    gid => 2001,
  }
  ->

  user {$username:
    ensure => present,
    gid => $groupname,
    require => Group[$groupname],
  }
}
