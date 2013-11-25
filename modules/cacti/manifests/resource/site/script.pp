define cacti::resource::site::script (
  $content,
  $scriptDir,
  $deployDir        = undef,
  $dbSenseUser      = undef,
  $dbSensePassword  = undef
) {

  file {"${scriptDir}/${name}":
    ensure  => file,
    content => $content,
  }
}