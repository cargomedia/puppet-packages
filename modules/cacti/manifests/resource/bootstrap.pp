class cacti::resource::bootstrap (
  $deployDir = undef,
  $dbSenseUser = undef,
  $dbSensePassword = undef
){

  require 'cacti::resource::template::bootstrap'

  class {'cacti::resource::site::bootstrap':
    deployDir => $deployDir,
    dbSenseUser => $dbSenseUser,
    dbSensePassword => $dbSensePassword,
  }

}