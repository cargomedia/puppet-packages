class capistrano {

  $version = $::facts['lsbdistcodename'] == 'wheezy' ? { true => '3.4.1', default => present }

  ruby::gem { 'net-ssh':
    ensure => '2.8.0',
  }
  ->

  ruby::gem { 'capistrano':
    ensure => $version,
  }
}
