class backup::server (
  $type = $rdiff::params::type
) inherits backup::params {

  include 'backup'

  case $type {
    'rdiff': {
      include 'backup::base::rdiff'
    }
    default: {
      fail ("Unknown backup type ${type}!")
    }
  }

}