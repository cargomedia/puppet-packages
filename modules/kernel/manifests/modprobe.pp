define kernel::modprobe(
  $content
) {

  file { "/etc/modprobe.d/${title}.conf":
    ensure  => file,
    owner   => '0',
    group   => '0',
    mode    => '0644',
    content => $content
  }

}
