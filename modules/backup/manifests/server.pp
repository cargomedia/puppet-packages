class backup::server (
  $type = $rdiff::params::type
) inherits backup::params {

  case $type {
    'rdiff': {
      include 'backup::base::rdiff'
    }
    default: {
      fail ("Unknown backup type ${type}!")
    }
  }

}