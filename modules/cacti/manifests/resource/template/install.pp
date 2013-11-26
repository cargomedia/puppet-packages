define cacti::resource::template::install ($content, $template_dir) {

  file {"${template_dir}/${name}":
    ensure  => file,
    content => $content,
  }

}