class uglify {

  require 'nodejs'

  package {'uglify-js':
    ensure => '2.4.13',
    provider => 'npm',
  }
}
