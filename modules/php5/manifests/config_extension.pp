define php5::config_extension (
  $extension = $name,
  $content = ''
) {


  file { "/etc/php5/mods-available/${extension}.ini":
    ensure  => file,
    content => $content,
    owner   => '0',
    group   => '0',
    mode    => '0644',
  }

  exec { "exec php5enmod ${extension}":
    command     => "php5enmod ${extension}",
    path        => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
    subscribe   => File["/etc/php5/mods-available/${extension}.ini"],
    refreshonly => true,
  }
}
