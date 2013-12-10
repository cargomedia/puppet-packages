class ruby::gem::memcached {

  package {'libsasl2-dev':
    ensure => present
  }
  ->

  ruby::gem {'memcached':
    ensure => present,
  }
}
