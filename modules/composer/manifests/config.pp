define composer::config(
  $user = 'root',
  $user_home = '/root',
  $github_oauth = undef
) {

  require 'composer'

  file {"${user_home}/.composer":
    ensure => directory,
    owner => $user,
    group => $user,
    mode => '0644',
  }

  file {"${user_home}/.composer/config.json":
    ensure => file,
    content => template('composer/config'),
    owner => $user,
    group => $user,
    mode => '0644',
  }
}
