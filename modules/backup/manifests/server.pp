class backup::server (
  $type = 'rdiff'
) {

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