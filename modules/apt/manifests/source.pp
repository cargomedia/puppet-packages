define apt::source(
  $ensure = present,
  $entries = {},
  $keys  = [],
) {

  include 'apt::update'

  file { "${name}.list":
    ensure  => $ensure? { present => file, default => $ensure},
    path    => "/etc/apt/sources.list.d/${name}.list",
    owner   => '0',
    group   => '0',
    mode    => '0644',
    content => template("${module_name}/source.list"),
    require => File['/etc/apt/sources.list.d/'],
    notify  => Exec['apt_update'],
  }

  unless $keys == []  {
    create_resources(apt::key, $keys, { ensure => present })
  }

}
