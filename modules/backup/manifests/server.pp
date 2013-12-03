class backup::server (
  $type = 'rdiff'
) {

  case $type {
    'rdiff': {
      require 'rdiff-backup'
    }
    default: {
      fail ("Unknown backup type ${type}!")
    }
  }

}
