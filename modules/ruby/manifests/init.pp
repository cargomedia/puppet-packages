class ruby {

  require 'apt'

  $packages = $::lsbdistcodename ? {
    /vivid/   => ['ruby'],
    default   => ['ruby', 'ruby-dev', 'ri'],
  }

  package { $packages:
    ensure   => present,
    provider => 'apt',
  }
}
