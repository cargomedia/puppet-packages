define php5::config_extension (
  $extension = $name
) {

  if $::lsbdistcodename == 'wheezy' {
    $conf_dir = 'mods-available'
  } else {
    $conf_dir = 'conf.d'
  }

  file {"/etc/php5/${conf_dir}/${extension}.ini":
    ensure => file,
    content => template("php5/extension/${extension}/conf.ini"),
    owner => '0',
    group => '0',
    mode => '0644',
    before => Exec['exec php5enmod']
  }

  if $::lsbdistcodename == 'wheezy' {
    exec {'exec php5enmod':
      command => "php5enmod ${extension}",
      path => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
    }
  }
}
