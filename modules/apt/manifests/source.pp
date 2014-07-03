define apt::source(
  $ensure = present,
  $entries = [],
  $keys  = [],
) {

  require 'apt'
  include 'apt::update'

  file { "/etc/apt/sources.list.d/${name}.list":
    ensure  => $ensure? { present => file, default => $ensure},
    owner   => '0',
    group   => '0',
    mode    => '0644',
    content => template("${module_name}/source.list"),
    notify  => Exec['apt_update'],
  }

  unless $keys == []  {
    create_resources(apt::key, $keys, { ensure => $ensure })
  }

}
