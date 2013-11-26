define cacti::resource::site::script (
  $content,
  $script_dir,
  $deploy_dir         = undef,
  $db_sense_user      = undef,
  $db_sense_password  = undef
) {

  file {"${script_dir}/${name}":
    ensure  => file,
    content => $content,
  }

}