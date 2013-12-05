class cacti::resource::bootstrap (
  $deploy_dir = undef,
  $db_sense_user = 'cacti-sense',
  $db_sense_password = 'password'
) {

  require 'cacti::resource::template::bootstrap'

  class {'cacti::resource::site::bootstrap':
    deploy_dir => $deploy_dir,
    db_sense_user => $db_sense_user,
    db_sense_password => $db_sense_password,
  }

}