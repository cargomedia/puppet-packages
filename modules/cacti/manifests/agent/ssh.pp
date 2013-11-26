class cacti::agent::ssh (
  $user_id  = $cacti::params::user_id,
  $group_id = $cacti::params::group_id
) inherits cacti::params {

  $user_name = $cacti::params::user_name
  $group_name = $cacti::params::group_name

  class {'cacti':
    user_id    => $user_id,
    group_id   => $group_id,
  }
  ->

  file {"/home/${user_name}":
    ensure  => directory,
    group   => $group_name,
    owner   => $user_name,
    mode    => '0750',
  }
  ->

  file {"/home/${user_name}/.ssh":
    ensure  => directory,
    group   => $group_name,
    owner   => $user_name,
    mode    => '0750',
  }
  ->

  file {"/home/${user_name}/.ssh/authorized_keys":
    ensure  => file,
    content => template('cacti/agent/ssh/authorized_keys'),
    group   => $group_name,
    owner   => $user_name,
    mode    => '0750',
  }

}
