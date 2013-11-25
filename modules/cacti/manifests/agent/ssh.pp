class cacti::agent::ssh (
  $userId     = $cacti::params::userId,
  $groupId    = $cacti::params::groupId
) inherits cacti::params {

  $userName = 'cacti'
  $groupName = 'cacti'

  class {'cacti':
    userId    => $userId,
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
    content => template("cacti/agent/authorized_keys"),
    group   => $groupName,
    owner   => $userName,
    mode    => '0750',
  }

}
