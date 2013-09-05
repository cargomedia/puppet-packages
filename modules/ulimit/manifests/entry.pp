define ulimit::entry ($content) {

  file { "/etc/security/limits.d/${name}":
    content => $content,
    ensure => file,
    group => '0',
    owner => '0',
    mode => '644',
  }
}
