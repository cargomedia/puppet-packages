class ruby {

  require 'apt'

  $packages = $::lsbdistcodename ? {
    /wheezy/ => ['ruby', 'ruby-dev', 'ri'],
    default  => ['ruby', 'ruby-dev'],
  }

  package { $packages:
    ensure   => present,
    provider => 'apt',
  }
}
