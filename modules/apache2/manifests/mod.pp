define apache2::mod (
  $enabled = true,
  $configuration = undef,
  $load_configuration = undef
) {

  require 'apache2'
  include 'apache2::service'

  file {"/etc/apache2/mods-enabled/${name}.load":
    ensure => $enabled ? {true => link, false => absent},
    target => "/etc/apache2/mods-available/${name}.load",
    group => '0',
    owner => '0',
    mode => '0644',
    require => Class['apache2'],
    notify => Service['apache2'],
  }

  if $load_configuration {
    file {"/etc/apache2/mods-available/${name}.load":
      ensure  => file,
      content => $load_configuration,
      owner   => '0',
      group   => '0',
      mode    => '0644',
      require => Class['apache2'],
      notify => Service['apache2'],
    }
  }

  if $configuration {
    file {"/etc/apache2/mods-available/${name}.conf":
      ensure => file,
      content => $configuration,
      group => '0',
      owner => '0',
      mode => '0644',
      require => Class['apache2'],
      notify => Service['apache2'],
    }
    ->

    file {"/etc/apache2/mods-enabled/${name}.conf":
      ensure => $enabled ? {true => link, false => absent},
      target => "/etc/apache2/mods-available/${name}.conf",
      group => '0',
      owner => '0',
      mode => '0644',
      require => Class['apache2'],
      notify => Service['apache2'],
    }
  }
}
