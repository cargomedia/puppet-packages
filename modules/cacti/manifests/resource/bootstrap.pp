class cacti::resource::bootstrap (
  $deploy_dir = $cacti::params::deploy_dir,
  $db_sense_user = $cacti::params::db_sense_user,
  $db_sense_password = $cacti::params::db_sense_password
) inherits cacti::params {

  require 'cacti::resource::template::bootstrap'

  class {'cacti::resource::site::bootstrap':
    deploy_dir => $deploy_dir,
    db_sense_user => $db_sense_user,
    db_sense_password => $db_sense_password,
  }

}