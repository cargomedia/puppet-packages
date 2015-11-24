class less {

  require 'apt'
  require 'nodejs'

  package { 'less':
    ensure   => present,
    provider => 'apt',
    provider => 'npm',
  }
}
