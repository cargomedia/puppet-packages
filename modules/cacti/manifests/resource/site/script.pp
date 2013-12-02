define cacti::resource::site::script (
  $content,
  $deploy_dir         = undef,
  $db_sense_user      = undef,
  $db_sense_password  = undef
) {

  file {"/usr/share/cacti/site/scripts/${name}":
    ensure  => file,
    content => $content,
    require => Package['cacti'],
  }

}