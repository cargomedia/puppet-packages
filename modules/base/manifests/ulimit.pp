class base::ulimit (
    $limits = []
) {

  file { "/etc/security/limits.conf":
    ensure  => file,
    group => '0', owner => '0', mode => '644',
    content => template ('base/ulimits'),
  }
}
