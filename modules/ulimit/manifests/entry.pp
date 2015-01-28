define ulimit::entry ($limits) {

  require 'ulimit'

  file { "/etc/security/limits.d/${name}":
    ensure  => file,
    content => template ('ulimit/limits'),
    group   => '0',
    owner   => '0',
    mode    => '0644',
  }
}
