define squid_deb_proxy::allowed_mirrors (
  $mirrorList,
) {

  include 'squid_deb_proxy'

  file { "/etc/squid-deb-proxy/mirror-dstdomain.acl.d/${title}":
    ensure  => file,
    content => template("${module_name}/mirror-dstdomain.acl.erb"),
    mode    => '0644',
    owner   => '0',
    group   => '0',
    notify  => Service['squid-deb-proxy'];
  }
}
