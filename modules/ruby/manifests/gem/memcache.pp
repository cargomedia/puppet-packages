class ruby::gem::memcache {

  package {'libsasl2-dev':
    ensure => present
  }
  ->

  ruby::gem {'memcache':
    ensure => present,
  }
}