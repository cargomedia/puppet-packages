class cacti::agent::ssh (
  $userName   = $cacti::params::userName,
  $userId     = $cacti::params::userId,
  $groupName  = $cacti::params::groupName,
  $groupId    = $cacti::params::groupId
) inherits cacti::params {

  class {'cacti':
    userName  => $userName,
    userId    => $userId,
    groupName => $groupName,
    groupId   => $groupId,
  }
  ->

  file {"/home/${userName}":
    ensure  => directory,
    group   => $groupName,
    owner   => $userName,
    mode    => '0750',
  }
  ->

  file {"/home/${userName}/.ssh":
    ensure  => directory,
    group   => $groupName,
    owner   => $userName,
    mode    => '0750',
  }
  ->

  file {"/home/${userName}/.ssh/authorized_keys":
    ensure  => file,
    content => template("${module_name}/agent/authorized_keys"),
    group   => $groupName,
    owner   => $userName,
    mode    => '0750',
  }

}
