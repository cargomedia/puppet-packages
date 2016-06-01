class phantomjs($version = '2.1.7') {

  require 'nodejs'
  include 'apt'

  ensure_packages(['fontconfig', 'bzip2'], {provider => 'apt'})

  package { 'phantomjs-prebuilt':
    ensure   => $version,
    provider => 'npm',
  }
}
