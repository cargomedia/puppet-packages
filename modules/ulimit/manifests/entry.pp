define ulimit::entry ($content) {

  file { "/etc/security/limits.d/${name}":
    ensure => file,
    content => $content,
    group => '0',
    owner => '0',
    mode => '0644',
  }
}
