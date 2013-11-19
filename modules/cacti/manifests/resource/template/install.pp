define cacti::resource::template::install ($content, $templateDir) {

  file {"${templateDir}/${name}":
    ensure  => file,
    content => $content,
  }
}