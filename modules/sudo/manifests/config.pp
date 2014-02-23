define sudo::config(
  $content
) {

  file {"/etc/sudoers.d/${title}":
    ensure => file,
    owner => '0',
    group => '0',
    mode => '0440',
    content => $content,
  }
}
