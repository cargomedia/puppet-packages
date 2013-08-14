define apt::source(
  $ensure = present,
  $entries = {},
  $keys  = [],
) {

  include 'apt::update'

  file { "/etc/apt/sources.list.d/":
    ensure => directory,
    owner   => root,
    group   => root,
    mode    => '0755',
  }

  file { "${name}.list":
    ensure  => $ensure? { present => file, default => $ensure},
    path    => "/etc/apt/sources.list.d/${name}.list",
    owner   => root,
    group   => root,
    mode    => '0644',
    content => template("${module_name}/source.list.erb"),
    require => File['/etc/apt/sources.list.d/'],
    notify  => Exec['apt_update'],
  }

  unless $keys == []  {
    create_resources(apt::key, $keys, { ensure => present })
  }

}
