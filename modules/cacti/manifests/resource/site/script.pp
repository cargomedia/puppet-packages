define cacti::resource::site::script ($content, $scriptDir) {

  file {"${scriptDir}/${name}":
    ensure  => file,
    content => $content,
  }
}