class cacti::client(
  $username   = $cacti::params::username,
  $groupname  = $cacti::params::groupname
) inherits cacti::params {

  validate_string($username)
  validate_string($groupname)

  include 'cacti'
  require 'snmpd'

  file{"/home/$username":
    ensure => directory,
    group => $groupname,
    owner => $username,
    mode => '750',
  }
  ->

  file{"/home/$username/.ssh":
    ensure => directory,
    group => $groupname,
    owner => $username,
    mode => '750',
  }
  ->

  file{"/home/$username/.ssh/authorizated_keys":
    ensure  => file,
    content => template("${module_name}/ssh/authorizated_keys"),
    group => $groupname,
    owner => $username,
    mode => '750',
  }
}
