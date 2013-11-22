class pulsar ($repository = undef) {

  require 'capistrano'
  require 'git'

  ruby::gem {'pulsar':
    ensure => present,
  }

  if $repository {
    environment::variable {'PULSAR_CONF_REPO':
      value => $repository
    }
  }
}
