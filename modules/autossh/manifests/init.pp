define autossh (
  $user,
  $connection,
  $forwards,
  $options = { }
) {

  require 'apt'

  package { 'autossh':
    ensure   => present,
    provider => 'apt',
  }

  $argOptions = autossh_options($options, {
    'ServerAliveInterval'   => 30,
    'ServerAliveCountMax'   => 3,
    'StrictHostKeyChecking' => 'no',
  })

  $argForwards = autossh_forwards($forwards)

  daemon { "autossh-${name}":
    user    => $user,
    binary  => '/usr/bin/autossh',
    args    => "-N -M 0 ${argOptions} ${argForwards} ${connection}",
    require => Package['autossh'],
  }
}
