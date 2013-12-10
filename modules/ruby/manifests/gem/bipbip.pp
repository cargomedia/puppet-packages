class ruby::gem::bipbip ($version = 'present') {

  require 'ruby::gem::mysql2'
  require 'ruby::gem::memcached'

  ruby::gem {'bipbip':
    ensure => $version,
  }
}
