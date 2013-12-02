define cacti::resource::template::install ($content) {

  file {"/usr/share/cacti/templates/${name}":
    ensure  => file,
    content => $content,
    require => Package['cacti'],
  }

}