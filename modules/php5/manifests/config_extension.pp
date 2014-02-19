define php5::config_extension (
  $extension = $name,
  $content = ''
) {

  if $::lsbdistcodename == 'squeeze' {
    $conf_dir = 'conf.d'
  } else {
    $conf_dir = 'mods-available'
  }

  file {"/etc/php5/${conf_dir}/${extension}.ini":
    ensure => file,
    content => $content,
    owner => '0',
    group => '0',
    mode => '0644',
  }

  if $::lsbdistcodename != 'squeeze' {
    exec {"exec php5enmod ${extension}":
      command => "php5enmod ${extension}",
      path => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
      subscribe => File["/etc/php5/${conf_dir}/${extension}.ini"],
      refreshonly => true,
    }
  }
}
