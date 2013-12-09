class ruby::gem::copperegg_agents {

  require 'ruby::gem::mysql2'
  require 'ruby::gem::memcache'

  ruby::gem {'copperegg_agents':
    ensure => present,
  }
}