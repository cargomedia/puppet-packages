class backup::server (
  $type = $rdiff::params::type
) inherits backup::params {

  include 'backup'

  case $type {
    'rdiff': {
      require 'rdiff-backup'
    }
    default: {
      fail ("Unknown backup type ${type}!")
    }
  }

}