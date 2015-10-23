class browserify {

  require 'nodejs'

  package { 'browserify':
    ensure   => '11.2.0',
    provider => 'npm',
  }
}
