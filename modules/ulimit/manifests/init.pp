class ulimit (
  $limits = []
) {
  file { "/etc/security/limits.conf":
    ensure  => file,
    group => '0',
    owner => '0',
    mode => '0644',
    content => template ("${module_name}/limits"),
  }

  file { "/etc/security/limits.d/":
    ensure  => directory,
    group => '0',
    owner => '0',
    mode => '0644',
  }
}
