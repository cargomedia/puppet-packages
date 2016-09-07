define apt::preference (
  $package = $title,
  $pin,
  $pin_priority = 1001,
) {

  include 'apt'

  file { "/etc/apt/preferences.d/${package}.pref":
    ensure  => file,
    content => template("${module_name}/preferences.erb"),
    owner   => 0,
    group   => 0,
    mode    => '0644',
  }
}
