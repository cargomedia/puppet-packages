define janus::role::streaming::cluster_register(
  $url,
  $content
) {

  file { "/usr/bin/janus_register_${title}":
    ensure  => file,
    content => template("${module_name}/role/streaming/register"),
    mode    => '0755',
    owner   => 0,
  }
  ->


}
