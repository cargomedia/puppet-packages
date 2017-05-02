class java::jre (
  $headless = false
) {

  if $::facts['lsbdistid'] == 'Debian' {
    $apt_sources = 'apt::source::backports'
    $install_options = ['-t', 'jessie-backports']
  } else {
    $apt_sources = 'apt'
    $install_options = []
  }

  require $apt_sources

  $suffix = $headless ? {
    true    => '-headless',
    default => '',
  }

  package { ["openjdk-8-jre${suffix}",'ca-certificates-java'] :
    ensure   => present,
    install_options => $install_options,
    provider => 'apt',
  }

}
