class uglify {

  require 'nodejs'

  package {'uglify-js':
    ensure => present,
    provider => 'npm',
  }
}
