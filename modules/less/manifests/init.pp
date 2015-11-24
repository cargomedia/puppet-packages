class less {

  require 'apt'
  require 'nodejs'

  package { 'less':
    provider => 'apt',
    ensure   => present,
    provider => 'npm',
  }
}
