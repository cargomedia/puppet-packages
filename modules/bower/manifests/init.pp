class bower {

  require 'nodejs'

  package { 'bower':
    ensure   => '1.3.12',
    provider => 'npm',
  }
}
