class less {

  require 'nodejs'

  package {'less':
    ensure => present,
    provider => 'npm',
  }
}
