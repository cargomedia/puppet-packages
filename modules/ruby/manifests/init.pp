class ruby {

  require 'apt'

  $packages = $::lsbdistcodename ? {
    /vivid/   => ['rubygems'],
    default   => ['ruby', 'ruby-dev', 'ri'],
  }

  package { $packages:
    ensure   => present,
    provider => 'apt',
  }
}
