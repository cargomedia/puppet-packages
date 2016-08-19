class capistrano {

  if $::facts['lsbdistcodename'] == 'wheezy' {
    $version = '3.4.1'
  }

  ruby::gem { 'net-ssh':
    ensure => '2.8.0',
  }
  ->

  ruby::gem { 'capistrano':
    ensure => $version,
  }
}
