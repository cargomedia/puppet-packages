class capistrano {

  ruby::gem { 'net-ssh':
    ensure => '2.8.0',
  }
  ->

  ruby::gem { 'capistrano':
    ensure => present,
  }
}
