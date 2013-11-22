class capistrano {

  ruby::gem {'capistrano':
    ensure => present,
  }
}
