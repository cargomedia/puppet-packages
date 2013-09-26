class cacti (
  $username = 
)inherits {

  group{$groupname:
    ensure => present,
    gid => 2001,
  }
  ->

  user{$username:
    ensure => present,
    gid => $groupname,
    require => Group[$groupname],
  }
}
