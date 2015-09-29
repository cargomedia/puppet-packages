class capistrano {

  ruby::gem { 'net-ssh':
    ensure => '~>2.8',
  }
  ->

  ruby::gem { 'capistrano':
    ensure => present,
  }
}
