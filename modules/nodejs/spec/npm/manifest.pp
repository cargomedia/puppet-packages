node default {

  require 'nodejs'

  package {'redis':
    provider => 'npm',
    require => Class['nodejs'],
  }
}
