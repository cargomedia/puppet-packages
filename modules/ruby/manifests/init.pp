class ruby {

  require 'apt'

  $packages = $::facts['lsbdistcodename'] ? {
    /wheezy/ => ['ruby', 'ruby-dev', 'ri'],
    default  => ['ruby', 'ruby-dev'],
  }

  package { $packages:
    ensure   => present,
    provider => 'apt',
  }
}
