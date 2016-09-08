class pulsar ($repository = undef) {

  require 'capistrano'
  require 'git'

  ruby::gem { 'pulsar':
    ensure => '0.3.5',
  }

  if $repository {
    env::variable { 'PULSAR_CONF_REPO':
      value => $repository
    }
  }
}
