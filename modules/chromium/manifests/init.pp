class chromium {

  require 'apt'

  package { 'chromium-browser':
    ensure   => present,
    provider => 'apt',
  }
}
