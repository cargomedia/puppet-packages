class java::jre (
  $headless = false
) {

  $suffix = $headless ? {
    true    => '-headless',
    default => '',
  }

  case $::facts['lsbdistid'] {
    'Debian': {
      require 'apt::source::backports'
      $install_options = ['-t', "${::facts['lsbdistcodename']}-backports"]
    }
    default: {
      require 'apt'
      $install_options = []
    }
  }

  package { ["openjdk-8-jre${suffix}", 'ca-certificates-java']:
    ensure          => present,
    install_options => $install_options,
    provider        => 'apt',
  }

}
