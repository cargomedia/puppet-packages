class ruby::gem::mysql2 {

  package {'libmysqlclient-dev':
    ensure => present
  }
  ->

  ruby::gem {'mysql2':
    ensure => present,
  }
}
